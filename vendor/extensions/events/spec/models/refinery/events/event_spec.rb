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

      describe '.upcoming' do
        before :each do
        end

        it 'returns only highlighted events' do
          2.times { FactoryGirl.create :event, highlighted: true}
          3.times { FactoryGirl.create :event, highlighted: false }

          events = Event.upcoming highlighted: true
          events.values.flatten.count.should == 2
        end

        it 'returns an empty result if there are no highlighted events' do
          2.times { FactoryGirl.create :event, highlighted: false }

          events = Event.upcoming highlighted: true
          events.should be_empty
        end

        it 'only returns non repeating events when they are in the future' do
          FactoryGirl.create :event, highlighted: true, date: 1.day.ago.to_date
          FactoryGirl.create :event, highlighted: true, date: 1.week.ago.to_date
          event1 = FactoryGirl.create :event, highlighted: true, date: 1.day.from_now.to_date
          event2 = FactoryGirl.create :event, highlighted: true, date: 2.weeks.from_now.to_date
          2.times { FactoryGirl.create :event, highlighted: false }

          list = Event.upcoming(highlighted: true).values.flatten
          list.count.should == 2
          list.should include(event1)
          list.should include(event2)
        end

        it 'returns the correct events in the right format if the first three are non repeating' do
          event1 = FactoryGirl.create :event, title: 'Event1', date: 1.day.from_now.to_date, highlighted: true
          event2 = FactoryGirl.create :event, title: 'Event2', date: 1.week.from_now.to_date, highlighted: true
          event3 = FactoryGirl.create :event, title: 'Event3', date: 2.months.from_now.to_date, highlighted: true
          event4 = FactoryGirl.create :event, title: 'Event4', date: 3.months.from_now.to_date, highlighted: true, repeats: 'weekly'

          FactoryGirl.create :event, date: 1.day.ago, highlighted: true
          3.times {|x| FactoryGirl.create :event, highlighted: false, date: x.week.from_now }

          events = Event.upcoming highlighted: true

          events.values.flatten.size.should == 4
          events[1.day.from_now.to_date].should include(event1)
          events[1.week.from_now.to_date].should include(event2)
          events[2.months.from_now.to_date].should include(event3)
          events[3.months.from_now.to_date].should include(event4)
        end

        it 'returns the correct events in the right format for a mix of repeating and non repeating' do
          event1 = FactoryGirl.create :event, title: 'Event1', date: 1.day.from_now.to_date, highlighted: true, repeats: 'weekly'
          event2 = FactoryGirl.create :event, title: 'Event2', date: 2.weeks.from_now.to_date, highlighted: true, repeats: 'monthly'
          event3 = FactoryGirl.create :event, title: 'Event3', date: 2.months.from_now.to_date, highlighted: true, repeats: 'never'
          event4 = FactoryGirl.create :event, title: 'Event4', date: 3.months.from_now.to_date, highlighted: true, repeats: 'weekly'

          FactoryGirl.create :event, date: 1.day.ago, highlighted: true
          3.times {|x| FactoryGirl.create :event, highlighted: false, date: x.week.from_now }

          events = Event.upcoming highlighted: true

          events.values.flatten.size.should == 4

          events[1.day.from_now.to_date].should include(event1)
          events[(1.day.from_now + 1.week).to_date].should include(event1)
          events[2.weeks.from_now.to_date].should include(event2)
          events[(1.day.from_now + 2.weeks).to_date].should include(event1)
        end

        it 'returns the correct events in the right format for a mix of repeating and non repeating and events on the same day' do
          event1 = FactoryGirl.create :event, title: 'Event1', date: 1.day.from_now.to_date, highlighted: true, repeats: 'weekly'
          event2 = FactoryGirl.create :event, title: 'Event2', date: 1.day.from_now.to_date, highlighted: true, repeats: 'monthly'
          event3 = FactoryGirl.create :event, title: 'Event3', date: 10.days.from_now.to_date, highlighted: true, repeats: 'never', start_time: 10.hours.from_now
          event4 = FactoryGirl.create :event, title: 'Event4', date: 10.days.from_now.to_date, highlighted: true, repeats: 'weekly', start_time: 1.hour.from_now

          FactoryGirl.create :event, date: 1.day.ago, highlighted: true
          3.times {|x| FactoryGirl.create :event, highlighted: false, date: x.week.from_now }

          events = Event.upcoming highlighted: true

          events.values.flatten.size.should == 4

          events[1.day.from_now.to_date].should include(event1, event2)
          events[(1.week.from_now + 1.day).to_date].should include(event1)
          events[10.days.from_now.to_date].should include(event4)
        end

        it 'returns the correct events in the right format when there are repeating events that started in the past' do
          event1 = FactoryGirl.create :event, title: 'Event1', date: 1.day.ago.to_date, highlighted: true, repeats: 'weekly'
          event2 = FactoryGirl.create :event, title: 'Event2', date: 2.days.from_now.to_date, highlighted: true, repeats: 'weekly'
          event3 = FactoryGirl.create :event, title: 'Event3', date: (3.days.from_now.to_date - 10.months).to_date, highlighted: true, repeats: 'monthly'
          range = (1..3)
          range.each {|x| FactoryGirl.create :event, highlighted: false, date: x.week.from_now, repeats: 'never' }
          range.each {|x| FactoryGirl.create :event, highlighted: false, date: x.week.ago, repeats: 'never'  }
          range.each {|x| FactoryGirl.create :event, highlighted: true, date: x.week.ago, repeats: 'never' }

          events = Event.upcoming highlighted: true

          events.values.flatten.size.should == 4
          events[2.days.from_now.to_date].should include(event2)
          events[3.days.from_now.to_date].should include(event3)
          events[(1.day.ago + 1.week).to_date].should include(event1)
          events[((2.days.from_now.to_date) + 1.week).to_date].should include(event2)
        end
      end

      describe '.for_date_range' do
        before :each do
          @old_repeating_event = FactoryGirl.create :event, title: 'Old Repeating in Range', date: (2.days.from_now - 10.months).to_date, repeats: 'monthly'
          @before_range_event = FactoryGirl.create :event, title: 'Before range event', date: 2.days.ago.to_date, repeats: 'never'
          @after_range_event = FactoryGirl.create :event, title: 'After range event', date: 2.weeks.from_now.to_date, repeats: 'never'
          @first_event_in_range = FactoryGirl.create :event, title: 'First range event', date: 2.days.from_now.to_date, repeats: 'never', highlighted: true
          @second_event_in_range = FactoryGirl.create :event, title: 'Second range event', date: 2.days.from_now.to_date, repeats: 'never', highlighted: true
          @third_event_in_range = FactoryGirl.create :event, title: 'Third range event', date: 3.days.from_now.to_date, repeats: 'never'
          @fourth_event_in_range = FactoryGirl.create :event, title: 'Fourth range event', date: 4.days.from_now.to_date, repeats: 'never'
          @first_event_in_range_with_time = FactoryGirl.create :event, title: 'First range event with time', date: 2.days.from_now.to_date, repeats: 'never', start_time: 1.hour.from_now

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

        it 'returns correctly an old event even that repeats during the range' do
          @events[2.days.from_now.to_date].should include(@old_repeating_event)
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

        it 'returns the correct events for a single day range' do
          events = Event.for_date_range(2.days.from_now)
          events.size.should == 1
          events.values.flatten.size.should == 3
          events[2.days.from_now.to_date].should include(@first_event_in_range)
          events[2.days.from_now.to_date].should include(@second_event_in_range)
          events[2.days.from_now.to_date].should include(@first_event_in_range_with_time)
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

        it 'returns the events sorted by start time' do
          @events.values.each do |events|
            events.should == events.sort_by { |e| e.start_time or e.date.beginning_of_day }
          end
        end

        it 'returns the events according to the condition specified' do
          events = Event.for_date_range(Time.now, 5.days.from_now, highlighted: true)
          events.values.flatten.size.should == 2
          events.values.flatten.each { |e| e.highlighted.should == true}
        end
      end
    end
  end
end