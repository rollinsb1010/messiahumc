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

      describe '#weekly?' do
        context 'for a weekly event' do
          let(:event) { FactoryGirl.build :weekly_event }

          it 'returns true' do
            event.should be_weekly
          end
        end

        context 'for a non weekly event' do
          let(:monthly_event) { FactoryGirl.build :monthly_event }
          let(:non_repeating_event) { FactoryGirl.build :event }

          it 'returns false' do
            monthly_event.should_not be_weekly
            non_repeating_event.should_not be_weekly
          end
        end
      end

      describe '#monthly?' do
        context 'for a monthly event' do
          let(:event) { FactoryGirl.build :monthly_event }

          it 'returns true' do
            event.should be_monthly
          end
        end

        context 'for a non monthly event' do
          let(:weekly_event) { FactoryGirl.build :weekly_event }
          let(:non_repeating_event) { FactoryGirl.build :event }

          it 'returns false' do
            weekly_event.should_not be_monthly
            non_repeating_event.should_not be_monthly
          end
        end
      end

      describe '#next_date' do
        context 'for non repeating event' do
          let(:event) { FactoryGirl.build :event }

          it 'returns the same date' do
            event.next_date.should == event.date
          end

          context 'with a future date context' do
            it 'returns the same date' do
              event.next_date(1.week.from_now.to_date).should == event.date
            end
          end
        end

        context 'for a weekly event' do
          context 'from the past' do
            let(:event) { FactoryGirl.build :weekly_event, date: 4.days.ago.to_date }

            it 'returns the date for this week' do
              event.next_date.should == 3.days.from_now.to_date
            end
          end

          context 'from the future' do
            let(:event) { FactoryGirl.build :weekly_event, date: 10.days.from_now.to_date }

            it 'returns the date for its next week' do
              event.next_date.should == (event.date + 1.week).to_date
            end
          end

          context 'from this week' do
            let(:event) { FactoryGirl.build :weekly_event, date: 4.days.from_now.to_date }

            it 'returns the date for the next week' do
              event.next_date.should == (event.date + 1.week).to_date
            end
          end
        end

        context 'for a monthly event' do
          context 'from the past' do
            let(:event) { FactoryGirl.build :monthly_event, date: (2.months.ago - 2.weeks).to_date }

            it 'returns the date for this month' do
              event.next_date.should == (1.month.from_now - 2.weeks).to_date
            end
          end

          context 'from the future' do
            let(:event) { FactoryGirl.build :monthly_event, date: (2.months.from_now + 1.week).to_date }

            it 'returns the same date' do
              event.next_date.should == event.date
            end
          end

          context 'from this month' do
            context 'before today' do
              let(:event) { FactoryGirl.build :monthly_event, date: 1.day.ago.to_date }

              before :each do
                Timecop.travel(2012, 1, 2)
              end

              it 'returns the date for the next month' do
                event.next_date.should == (event.date + 1.month).to_date
              end

              after :each do
                Timecop.travel(2012, 1, 1)
              end
            end

            context 'after today' do
              let(:event) { FactoryGirl.build :monthly_event, date: Time.now.to_date }

              it 'returns the date for the next month' do
                event.next_date.should == event.date
              end
            end
          end
        end
      end

      describe '.highlighted' do
        let(:highlighted_event) { FactoryGirl.build :event, highlighted: true }
        let(:not_highlighted_event) { FactoryGirl.build :event, highlighted: false }
        let(:events) { [highlighted_event, not_highlighted_event]}

        before :each do
          Event.stub(:upcoming).with(any_args).and_return(events)
          Event.stub(:upcoming).with(highlighted: true).and_return([highlighted_event])
        end

        it 'returns only highlighted events' do
          events = Event.highlighted
          events.should have(1).event
          events.should include(highlighted_event)
        end
      end

      describe '.possible_since' do
        context 'for non repeating events' do
          let(:past_event) { FactoryGirl.create :event, date: 2.weeks.ago.to_date }
          let(:future_event) { FactoryGirl.create :event, date: 2.weeks.from_now.to_date }

          before :each do
            past_event.save
            future_event.save
          end

          it 'only includes events in the future' do
            events = Event.possible_since(Time.now.to_date)

            events.should have(1).event
            events.should include(future_event)
          end
        end

        context 'for repeating events' do
          context 'in the past' do
            let(:monthly_event) { FactoryGirl.create :monthly_event, date: 3.months.ago.to_date }
            let(:weekly_event) { FactoryGirl.create :weekly_event, date: 3.weeks.ago.to_date }

            before :each do
              monthly_event.save
              weekly_event.save
            end

            it 'includes all events' do
              events = Event.possible_since(Time.now.to_date)

              events.should have(2).events
              events.should include(monthly_event)
              events.should include(weekly_event)
            end
          end

          context 'in the future' do
            let(:monthly_event) { FactoryGirl.create :monthly_event, date: 3.months.from_now.to_date }
            let(:weekly_event) { FactoryGirl.create :weekly_event, date: 3.weeks.from_now.to_date }

            before :each do
              monthly_event.save
              weekly_event.save
            end

            it 'includes all events' do
              events = Event.possible_since(Time.now.to_date)

              events.should have(2).events
              events.should include(monthly_event)
              events.should include(weekly_event)
            end
          end
        end
      end

      describe '.upcoming' do
        before :each do
        end

        it 'returns an empty result if there are no events in the future' do
          2.times { FactoryGirl.create :event, date: 1.day.ago.to_date, repeats: 'never' }

          events = Event.upcoming
          events.should be_empty
        end

        it 'only returns non repeating events when they are in the future' do
          FactoryGirl.create :event, date: 1.day.ago.to_date
          FactoryGirl.create :event, date: 1.week.ago.to_date
          event1 = FactoryGirl.create :event, date: 1.day.from_now.to_date
          event2 = FactoryGirl.create :event, date: 2.weeks.from_now.to_date

          list = Event.upcoming.values.flatten
          list.should have(2).events
          list.should include(event1)
          list.should include(event2)
        end

        it 'returns the correct events in the right format if the first three are non repeating' do
          event1 = FactoryGirl.create :event, title: 'Event1', date: 1.day.from_now.to_date
          event2 = FactoryGirl.create :event, title: 'Event2', date: 1.week.from_now.to_date
          event3 = FactoryGirl.create :event, title: 'Event3', date: 2.months.from_now.to_date
          event4 = FactoryGirl.create :event, title: 'Event4', date: 3.months.from_now.to_date, repeats: 'weekly'

          FactoryGirl.create :event, date: 1.day.ago

          events = Event.upcoming

          events.values.flatten.should have(4).events
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
