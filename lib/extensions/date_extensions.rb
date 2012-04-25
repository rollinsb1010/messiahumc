module DateExtensions
  def next_date_for_weekday(weekday_number)
    Date.next_date_for_weekday(self, weekday_number)
  end

  def next_date_for_day_number(day_number)
    Date.next_date_for_day_number(self, day_number)
  end

  module ClassMethods
    def next_date_for_weekday(context_date, weekday_number)
      Chronic.parse("next #{Date::DAYNAMES[weekday_number]}", now: context_date).to_date
    end

    def next_date_for_day_number(initial_date, day_number)
      next_date = nil
      number = 0
      number = 1 if initial_date.day > day_number

      while next_date.nil? and number <= 12
        next_date = Chronic.parse("#{Date::MONTHNAMES[(initial_date + number.months).month]} #{day_number}", now: initial_date)
        number += 1
      end

      next_date.to_date
    end

    def dates_for_weekday(start_date, end_date, weekday_number)
      dates = []
      current_date = start_date

      while current_date <= end_date
        dates << current_date if current_date.wday == weekday_number
        current_date = current_date.next_date_for_weekday(weekday_number)
      end

      dates
    end

    def dates_for_day_number(start_date, end_date, day_number)
      dates = []

      current_date = Chronic.parse("#{Date::MONTHNAMES[start_date.month]} #{day_number}")
      current_date = start_date.next_date_for_day_number(day_number) if current_date.nil? or current_date < start_date
      current_date = current_date.to_date

      while current_date <= end_date
        dates << current_date.to_date if current_date.day == day_number
        current_date = (current_date + 1.day).next_date_for_day_number(day_number)
      end

      dates
    end
  end
end

class Date
  include DateExtensions
  extend DateExtensions::ClassMethods
end
