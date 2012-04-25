require 'spec_helper'

module Refinery
  module Events
    describe Event do
      describe 'validations' do
        subject do
          FactoryGirl.build :event, title: 'The event'
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == 'The event' }
      end

      describe '#repeats?' do
        context 'for a weekly and monthly event' do
          let(:weekly_event) { FactoryGirl.build :weekly_event }
          let(:monthly_event) { FactoryGirl.build :monthly_event }

          it 'returns true' do
            weekly_event.should be_repeating
            monthly_event.should be_repeating
          end
        end

        context 'for a non repeating event' do
          let(:event) { FactoryGirl.build :event }

          it 'returns false' do
            event.should_not be_repeating
          end
        end
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

        it 'returns an empty result if there are no events' do
          Event.stub(:possible_since).with(any_args).and_return Event
          Event.stub(:limit).with(any_args).and_return []

          events = Event.upcoming
          events.should be_empty
        end

        context 'for non repeating events' do
          let(:event1) { FactoryGirl.build :event, date: 1.day.from_now.to_date }
          let(:event2) { FactoryGirl.build :event, date: 2.weeks.from_now.to_date }

          it 'includes only one instance of each' do
            Event.stub(:possible_since).with(any_args).and_return Event
            Event.stub(:limit).with(any_args).and_return [event1, event2]

            list = Event.upcoming.values.flatten
            list.should have(2).events
            list.should include(event1)
            list.should include(event2)
          end
        end

        context 'when the first three are non repeating' do
          let(:event1) { FactoryGirl.build :event, date: 1.day.from_now.to_date }
          let(:event2) { FactoryGirl.build :event, date: 1.week.from_now.to_date }
          let(:event3) { FactoryGirl.build :event, date: 2.months.from_now.to_date }
          let(:event4) { FactoryGirl.build :weekly_event, date: 3.months.from_now.to_date }

          it 'returns the correct events in the right format' do
            Event.stub(:possible_since).with(any_args).and_return Event
            Event.stub(:limit).with(any_args).and_return [event1, event2, event3, event4]

            events = Event.upcoming

            events.values.flatten.should have(4).events
            events[1.day.from_now.to_date].should include(event1)
            events[1.week.from_now.to_date].should include(event2)
            events[2.months.from_now.to_date].should include(event3)
            events[3.months.from_now.to_date].should include(event4)
          end
        end

        context 'for a mix of repeating and non repeating' do
          let(:event1) { FactoryGirl.build :weekly_event, title: 'Event1', date: 1.day.from_now.to_date }
          let(:event2) { FactoryGirl.build :monthly_event, title: 'Event2', date: 2.weeks.from_now.to_date }
          let(:event3) { FactoryGirl.build :event, title: 'Event3', date: 2.months.from_now.to_date }
          let(:event4) { FactoryGirl.build :weekly_event, title: 'Event4', date: 3.months.from_now.to_date }

          it 'returns the correct events in the right format' do
            Event.stub(:possible_since).with(any_args).and_return Event
            Event.stub(:limit).with(any_args).and_return [event1, event2, event3, event4]

            events = Event.upcoming

            events.values.flatten.should have(4).events
            events[1.day.from_now.to_date].should include(event1)
            events[(1.day.from_now + 1.week).to_date].should include(event1)
            events[2.weeks.from_now.to_date].should include(event2)
            events[(1.day.from_now + 2.weeks).to_date].should include(event1)
          end

          context 'and events on the same day' do
            let(:event1) { FactoryGirl.build :weekly_event, title: 'Event1', date: 1.day.from_now.to_date }
            let(:event2) { FactoryGirl.build :monthly_event, title: 'Event2', date: 1.day.from_now.to_date }
            let(:event3) { FactoryGirl.build :event, title: 'Event3', date: 10.days.from_now.to_date, start_time: 10.hours.from_now }
            let(:event4) { FactoryGirl.build :weekly_event, title: 'Event4', date: 10.days.from_now.to_date, start_time: 1.hour.from_now }

            it 'returns the correct events in the right format' do
              Event.stub(:possible_since).with(any_args).and_return Event
              Event.stub(:limit).with(any_args).and_return [event1, event2, event3, event4]

              events = Event.upcoming

              events.values.flatten.should have(4).events
              events[1.day.from_now.to_date].should include(event1, event2)
              events[(1.week.from_now + 1.day).to_date].should include(event1)
              events[10.days.from_now.to_date].should include(event4)
            end
          end
        end

        context 'for repeating events that started in the past' do
          let(:event1) { FactoryGirl.build :weekly_event, title: 'Event1', date: 1.day.ago.to_date }
          let(:event2) { FactoryGirl.build :weekly_event, title: 'Event2', date: 2.days.from_now.to_date }
          let(:event3) { FactoryGirl.build :monthly_event, title: 'Event3', date: (3.days.from_now.to_date - 10.months).to_date }

          it 'returns the correct events in the right format' do
            Event.stub(:possible_since).with(any_args).and_return Event
            Event.stub(:limit).with(any_args).and_return [event1, event2, event3]

            events = Event.upcoming highlighted: true

            events.values.flatten.should have(4).events
            events[2.days.from_now.to_date].should include(event2)
            events[3.days.from_now.to_date].should include(event3)
            events[(1.day.ago + 1.week).to_date].should include(event1)
            events[((2.days.from_now.to_date) + 1.week).to_date].should include(event2)
          end
        end
      end

      describe '.for_date_range' do
        let(:old_repeating_event) { FactoryGirl.build :monthly_event, title: 'Old Repeating in Range', date: (2.days.from_now - 10.months).to_date }
        let(:before_range_event) { FactoryGirl.build :event, title: 'Before range event', date: 2.days.ago.to_date }
        let(:after_range_event) { FactoryGirl.build :event, title: 'After range event', date: 2.weeks.from_now.to_date }
        let(:first_event_in_range) { FactoryGirl.build :event, title: 'First range event', date: 2.days.from_now.to_date }
        let(:second_event_in_range) { FactoryGirl.build :event, title: 'Second range event', date: 2.days.from_now.to_date }
        let(:third_event_in_range) { FactoryGirl.build :event, title: 'Third range event', date: 3.days.from_now.to_date }
        let(:fourth_event_in_range) { FactoryGirl.build :event, title: 'Fourth range event', date: 4.days.from_now.to_date }
        let(:first_event_in_range_with_time) { FactoryGirl.build :event, title: 'First range event with time', date: 2.days.from_now.to_date, start_time: 1.hour.from_now }
        let(:weekly_event_starts_in_range) { FactoryGirl.build :weekly_event, title: 'Weekly event starts in range', date: 1.day.from_now.to_date }
        let(:weekly_event_after_range) { FactoryGirl.build :weekly_event, title: 'Weekly event after range', date: 2.weeks.from_now.to_date }
        let(:weekly_event_included_not_in_range) { FactoryGirl.build :weekly_event, title: 'Weekly event before range included', date: 4.days.ago.to_date }
        let(:weekly_event_not_included_not_in_range) { FactoryGirl.build :weekly_event, title: 'Weekly event before range not included', date: 1.day.ago.to_date }
        let(:monthly_event_starts_in_range) { FactoryGirl.build :monthly_event, title: 'Monthly event starts in range', date: 1.day.from_now.to_date }
        let(:monthly_event_after_range) { FactoryGirl.build :monthly_event, title: 'Monthly event after range', date: 2.weeks.from_now.to_date }
        let(:monthly_event_included_not_in_range) { FactoryGirl.build :monthly_event, title: 'Monthly event before range included', date: (1.month.ago + 1.day).to_date }
        let(:monthly_event_not_included_not_in_range) { FactoryGirl.build :monthly_event, title: 'Monthly event before range not included', date: 4.days.ago.to_date }
        let(:in_range_events) { [first_event_in_range, second_event_in_range, third_event_in_range, fourth_event_in_range, first_event_in_range_with_time, weekly_event_starts_in_range, weekly_event_included_not_in_range, monthly_event_starts_in_range, monthly_event_included_not_in_range, old_repeating_event] }

        before :each do
          Event.stub(:possible_since).and_return Event
          Event.stub(:where).and_return in_range_events
        end

        it 'returns an empty hash for an invalid date range' do
          Event.for_date_range(Time.now, 5.days.ago).should be_empty
        end

        it 'returns the events in the in a date => events format' do
          events = Event.for_date_range(Time.now, 5.days.from_now)
          events[first_event_in_range.date].should include(first_event_in_range)
          events[third_event_in_range.date].should include(third_event_in_range)
        end

        it 'returns correctly an old event even that repeats during the range' do
          events = Event.for_date_range(Time.now, 5.days.from_now)
          events[2.days.from_now.to_date].should include(old_repeating_event)
        end

        context 'for non repeating events' do
          context 'in range' do
            it 'includes them all' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events.values.flatten.should include(first_event_in_range)
            end
          end

          context 'before the start date' do
            it 'does not include them' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events.values.flatten.should_not include(before_range_event)
            end
          end

          context 'after the start date' do
            it 'does not include them' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events = events.values.flatten

              events.should_not include(after_range_event)
              events.should_not include(weekly_event_after_range)
              events.should_not include(monthly_event_after_range)
            end
          end
        end

        context 'for weekly events' do
          context 'starting within the range' do
            it 'includes them all' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events.values.flatten.should include(weekly_event_starts_in_range)
            end
          end

          context 'that span 7 days or more' do
            it 'includes them all' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events = Event.for_date_range(Time.now, 1.week.from_now)
              events.values.flatten.should include(weekly_event_included_not_in_range)
            end
          end

          context 'not in the range' do
            context 'but with a day within the range' do
              it 'includes them all' do
                events = Event.for_date_range(Time.now, 5.days.from_now)
                events.values.flatten.should include(weekly_event_included_not_in_range)
              end
            end

            context 'without a day within the range' do
              it 'does not include them' do
                events = Event.for_date_range(Time.now, 5.days.from_now)
                events.values.flatten.should_not include(weekly_event_not_included_not_in_range)
              end
            end
          end

          it 'adds them to the correct dates' do
            events = Event.for_date_range(Time.now, 5.days.from_now)
            events[weekly_event_starts_in_range.date].should include(weekly_event_starts_in_range)
            events[3.days.from_now.to_date].should include(weekly_event_included_not_in_range)
          end
        end

        context 'for monthly events' do
          context 'starting within the range' do
            it 'includes them all' do
              events = Event.for_date_range(Time.now, 5.days.from_now)
              events.values.flatten.should include(monthly_event_starts_in_range)
            end
          end

          context 'not in range' do
            context 'but with a day within the range' do
              it 'includes them all' do
                events = Event.for_date_range(Time.now, 5.days.from_now)
                events.values.flatten.should include(monthly_event_included_not_in_range)
              end
            end

            context 'without a day within the range' do
              it 'does not include them' do
                events = Event.for_date_range(Time.now, 5.days.from_now)
                events.values.flatten.should_not include(monthly_event_not_included_not_in_range)
              end
            end
          end

          it 'adds them to the correct dates' do
            events = Event.for_date_range(Time.now, 5.days.from_now)
            events[monthly_event_starts_in_range.date].should include(monthly_event_starts_in_range)
            events[1.day.from_now.to_date].should include(monthly_event_included_not_in_range)
          end

          context 'with a day number not included in one month of the range' do
            it 'does not add it for that month' do
              monthly_event_on_31st = FactoryGirl.build :monthly_event, title: 'Monthly Event on 31st', date: Time.local(2011, 10, 31).to_date
              Event.stub(:where).and_return [monthly_event_on_31st]

              events = Event.for_date_range(Time.local(2012, 2, 1), Time.local(2012, 5, 31))
              dates = events.keys

              dates.should have(2).dates
              dates.should include(Time.local(2012, 3, 31).to_date)
              dates.should include(Time.local(2012, 5, 31).to_date)
            end
          end
        end

        it 'returns the correct events for a single day range' do
          Event.stub(:where).and_return [first_event_in_range, second_event_in_range, first_event_in_range_with_time]
          events = Event.for_date_range(2.days.from_now)

          events.should have(1).item
          events.values.flatten.should have(3).events
          events[2.days.from_now.to_date].should include(first_event_in_range)
          events[2.days.from_now.to_date].should include(second_event_in_range)
          events[2.days.from_now.to_date].should include(first_event_in_range_with_time)
        end

        context 'sorting' do
          it 'returns the events sorted by date' do
            events = Event.for_date_range(Time.now, 5.days.from_now)
            events.keys.should == events.keys.sort
          end

          it 'returns the events sorted by start time' do
            events = Event.for_date_range(Time.now, 5.days.from_now)
            events.values.each do |events|
              events.should == events.sort_by { |e| e.start_time or e.date.beginning_of_day }
            end
          end
        end

        it 'returns the events according to the condition specified' do
          highlighted = [FactoryGirl.build(:event, highlighted: true), FactoryGirl.build(:event, highlighted: true)]
          Event.stub(:possible_since).with(Time.now.to_date, highlighted: true).and_return highlighted
          highlighted.stub(:where).and_return highlighted

          events = Event.for_date_range(Time.now, 5.days.from_now, highlighted: true)

          events.values.flatten.should have(2).event
          events.values.flatten.each { |e| e.highlighted.should == true}
        end
      end
    end
  end
end
