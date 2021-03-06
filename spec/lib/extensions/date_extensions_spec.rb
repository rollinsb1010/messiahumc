require 'spec_helper'

describe DateExtensions do
  describe '#next_date_for_weekday' do
    let(:date) { Time.now.to_date }
    let(:next_date) { (date + 1.week).to_date }
    let(:weekday_number) { 3 }

    it 'delegates to .next_date_for_weekday passing self' do
      Date.should_receive(:next_date_for_weekday).with(date, weekday_number).and_return next_date

      result = date.next_date_for_weekday(weekday_number)
      result.should == next_date
    end
  end

  describe '#next_date_for_day_number' do
    let(:date) { Time.now.to_date }
    let(:next_date) { (date + 1.month).to_date }
    let(:day_number) { 15 }

    it 'delegates to .next_date_for_weekday passing self' do
      Date.should_receive(:next_date_for_day_number).with(date, day_number).and_return next_date

      result = date.next_date_for_day_number(day_number)
      result.should == next_date
    end
  end

  describe DateExtensions::ClassMethods do
    describe '.next_date_for_weekday' do
      let(:date) { 3.days.from_now }
      let(:context_date) { Date.today }

      it 'parses "next [day name]"' do
        Chronic.should_receive(:parse).with("next #{Date::DAYNAMES[Time.now.wday]}", now: context_date).and_return date
        Date.next_date_for_weekday(context_date, Time.now.wday)
      end

      it 'returns whatever Chronic parses as a date' do
        Chronic.stub(:parse).with(any_args).and_return date
        Date.next_date_for_weekday(context_date, Time.now.wday).should == date.to_date
      end
    end

    describe '.next_date_for_day_number' do
      let(:date) { 3.days.from_now }
      let(:context_date) { Date.today }
      let(:day_number) { context_date.day }

      context 'for the same day number as initial date' do
        it 'returns the same day' do
          Chronic.should_receive(:parse).with("#{Date::MONTHNAMES[context_date.month]} #{day_number}", now: context_date).and_return date
          Date.next_date_for_day_number(context_date, day_number)
        end
      end

      context 'for a greater day number than initial date' do
        let(:day_number) { context_date.day + 5 }
        it 'returns the same day' do
          Chronic.should_receive(:parse).with("#{Date::MONTHNAMES[context_date.month]} #{day_number}", now: context_date).and_return date
          Date.next_date_for_day_number(context_date, day_number)
        end
      end

      context 'for a smaller day number than initial date' do
        let(:day_number) { 1 }

        before(:each) { Timecop.travel(Time.local(2012, 1, 10)) }

        it 'returns the following date with that day number' do
          Chronic.should_receive(:parse).with("#{Date::MONTHNAMES[context_date.month + 1]} #{day_number}", now: context_date).and_return date
          Date.next_date_for_day_number(context_date, day_number)
        end
      end

      context 'for a date not included in all months' do
        let(:day_number) { 31 }

        before(:each) { Timecop.travel(Time.local(2012, 2, 1)) }

        it 'returns the next date with a valid month' do
          Chronic.should_receive(:parse).with("#{Date::MONTHNAMES[context_date.month]} #{day_number}", now: context_date).and_return nil
          Chronic.should_receive(:parse).with("#{Date::MONTHNAMES[context_date.month + 1]} #{day_number}", now: context_date).and_return date

          Date.next_date_for_day_number(context_date, day_number).should == date.to_date
        end
      end

      it 'returns whatever Chronic parses as a date' do
        Chronic.stub(:parse).with(any_args).and_return date
        Date.next_date_for_day_number(context_date, Time.now.day).should == date.to_date
      end
    end

    describe '.dates_for_weekday' do
      let(:start_date) { Time.now.to_date }
      let(:end_date) { (start_date + 6.days).to_date }

      context 'for a range less than a week' do
        context 'that includes the day' do
          it 'returns just one date' do
            dates = Date.dates_for_weekday(start_date, end_date, start_date.wday + 2)

            dates.should have(1).date
            dates.should include((start_date + 2.days).to_date)
          end
        end

        context 'that does not include the day' do
          let(:end_date) { (start_date + 2.days).to_date }

          it 'returns no dates' do
            dates = Date.dates_for_weekday(start_date, end_date, end_date.wday + 1)

            dates.should be_empty
          end
        end
      end

      context 'for a range larger than a week' do
        let(:end_date) { (start_date + 1.week + 2.days).to_date }

        context 'that includes the day more than once' do
          it 'returns one for each day occurrence' do
            dates = Date.dates_for_weekday(start_date, end_date, start_date.wday)

            dates.should have(2).dates
            dates.should include(start_date)
            dates.should include((start_date + 1.week).to_date)
          end
        end

        context 'that includes the day just once' do
          let(:date) { (start_date + 6.days).to_date }
          it 'returns just one date' do
            dates = Date.dates_for_weekday(start_date, end_date, date.wday)

            dates.should have(1).date
            dates.should include(date)
          end
        end
      end
    end

    describe '.dates_for_day_number' do
      context 'for a range smaller than a month' do
        let(:start_date) { Time.now.to_date }
        let(:end_date) { (start_date + 2.weeks).to_date }
        let(:date) { (start_date + 5.days).to_date }

        context 'and a day contained in the range' do
          it 'returns just one date' do
            dates = Date.dates_for_day_number(start_date, end_date, date.day)

            dates.should have(1).date
            dates.should include(date)
          end
        end
      end
    end
  end
end
