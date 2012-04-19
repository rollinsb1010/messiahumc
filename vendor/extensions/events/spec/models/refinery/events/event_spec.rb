require 'spec_helper'

module Refinery
  module Events
    describe Event do
      describe 'validations' do
        subject do
          FactoryGirl.create(:event, title: 'The event')
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == 'The event' }
      end

      describe '#in_range?' do
        context 'for non repeating event' do
          context 'in the range' do
            let(:event) { FactoryGirl.build :event, date: 2.days.ago.to_date }

            it 'returns true' do
              event.in_range?(3.days.ago.to_date, 1.day.ago.to_date).should be_true
            end
          end

          context 'before the start of the range' do
            let(:event) { FactoryGirl.build :event, date: 4.days.ago.to_date }

            it 'returns false' do
              event.in_range?(3.days.ago.to_date, 1.day.ago.to_date).should be_false
            end
          end

          context 'on the start of the range' do
            let(:event) { FactoryGirl.build :event, date: 3.days.ago.to_date }

            it 'returns true' do
              event.in_range?(3.days.ago.to_date, 1.day.ago.to_date).should be_true
            end
          end

          context 'after the end of the range' do
            let(:event) { FactoryGirl.build :event, date: 1.day.from_now.to_date }

            it 'returns false' do
              event.in_range?(3.days.ago.to_date, 1.day.ago.to_date).should be_false
            end
          end

          context 'on the end of the range' do
            let(:event) { FactoryGirl.build :event, date: 1.day.ago.to_date }

            it 'returns true' do
              event.in_range?(3.days.ago.to_date, 1.day.ago.to_date).should be_true
            end
          end
        end
      end

      describe '.for_date_range' do
        before :each do
          @before_range_event = FactoryGirl.create :event, title: 'Before range event', date: 2.days.ago.to_date, repeats: 'never'
          @after_range_event = FactoryGirl.create :event, title: 'After range event', date: 2.weeks.from_now.to_date, repeats: 'never'
          @first_event_in_range = FactoryGirl.create :event, title: 'First range event', date: 2.days.from_now.to_date, repeats: 'never'
          @second_event_in_range = FactoryGirl.create :event, title: 'Second range event', date: 2.days.from_now.to_date, repeats: 'never'
          @third_event_in_range = FactoryGirl.create :event, title: 'Third range event', date: 3.days.from_now.to_date, repeats: 'never'
          @fourth_event_in_range = FactoryGirl.create :event, title: 'Fourth range event', date: 4.days.from_now.to_date, repeats: 'never'

          @weekly_event_starts_in_range = FactoryGirl.create :event, title: 'Weekly event starts in range', date: 1.day.from_now.to_date, repeats: 'weekly'
          @weekly_event_after_range = FactoryGirl.create :event, title: 'Weekly event after range', date: 2.weeks.from_now.to_date, repeats: 'weekly'
          @weekly_event_included_not_in_range = FactoryGirl.create :event, title: 'Weekly event before range included', date: 4.days.ago.to_date, repeats: 'weekly'
          @weekly_event_not_included_not_in_range = FactoryGirl.create :event, title: 'Weekly event before range not included', date: 1.day.ago.to_date, repeats: 'weekly'
          @monthly_event_starts_in_range = FactoryGirl.create :event, title: 'Monthly event starts in range', date: 1.day.from_now.to_date, repeats: 'monthly'
          @monthly_event_after_range = FactoryGirl.create :event, title: 'Monthly event after range', date: 2.weeks.from_now.to_date, repeats: 'monthly'
          @monthly_event_included_not_in_range = FactoryGirl.create :event, title: 'Monthly event before range included', date: (1.month.ago + 1.day).to_date, repeats: 'monthly'
          @monthly_event_not_included_not_in_range = FactoryGirl.create :event, title: 'Monthly event before range not included', date: 4.days.ago.to_date, repeats: 'monthly'

          @events = Event.for_date_range(Time.now, 5.days.from_now)
        end

        it 'returns an empty hash for an invalid date range' do
          events = Event.for_date_range(Time.now, 5.days.ago).should be_empty
        end

        it 'includes the non repeating events in the range' do
          @events.values.flatten.should include(@first_event_in_range)
        end

        it 'does not include non repeating events before the start date' do
          @events.values.flatten.should_not include(@before_range_event)
        end

        it 'does not include any event that starts after the end date' do
          events = @events.values.flatten
          events.should_not include(@after_range_event)
          events.should_not include(@weekly_event_after_range)
          events.should_not include(@monthly_event_after_range)
        end

        it 'returns the events in the in a date => events format' do
          @events[@first_event_in_range.date].should include(@first_event_in_range)
          @events[@third_event_in_range.date].should include(@third_event_in_range)
        end

        it 'includes a weekly event that starts within the range' do
          @events.values.flatten.should include(@weekly_event_starts_in_range)
        end

        it 'includes a weekly event for a range that spans 7 days or more' do
          events = Event.for_date_range(Time.now, 1.week.from_now)
          events.values.flatten.should include(@weekly_event_included_not_in_range)
        end

        it 'includes a weekly event that does not start in the range but has a day within the range' do
          @events.values.flatten.should include(@weekly_event_included_not_in_range)
        end

        it 'does not include a weekly event that does not start in the range and does not have a day within the range' do
          @events.values.flatten.should_not include(@weekly_event_not_included_not_in_range)
        end

        it 'adds the weekly events to the correct dates' do
          @events[@weekly_event_starts_in_range.date].should include(@weekly_event_starts_in_range)
          @events[3.days.from_now.to_date].should include(@weekly_event_included_not_in_range)
        end

        it 'includes a monthly event that starts within the range' do
          @events.values.flatten.should include(@monthly_event_starts_in_range)
        end

        it 'includes a monthly event that does not start in the range but has a day within the range' do
          @events.values.flatten.should include(@monthly_event_included_not_in_range)
        end

        it 'does not include a monthly event that does not start in the range and does not have a day within the range' do
          @events.values.flatten.should_not include(@monthly_event_not_included_not_in_range)
        end

        it 'adds the monthly events to the correct dates' do
          @events[@monthly_event_starts_in_range.date].should include(@monthly_event_starts_in_range)
          @events[1.day.from_now.to_date].should include(@monthly_event_included_not_in_range)
        end

        it 'does not add a monthly event if the day number is not included in one month in the range' do
          Event.delete_all
          monthly_event_on_31st = FactoryGirl.create :event, title: 'Monthly Event on 31st', date: Time.local(2011, 10, 31).to_date, repeats: 'monthly'
          events = Event.for_date_range(Time.local(2012, 2, 1), Time.local(2012, 5, 31))
          dates = events.keys
          dates.size.should == 2
          dates.should include(Time.local(2012, 3, 31).to_date)
          dates.should include(Time.local(2012, 5, 31).to_date)
        end

        it 'returns the events sorted by date' do
          @events.keys.should == @events.keys.sort
        end
      end
    end
  end
end
