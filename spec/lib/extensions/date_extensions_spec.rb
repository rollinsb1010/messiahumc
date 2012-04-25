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
end
