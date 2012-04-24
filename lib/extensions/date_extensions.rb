class Date
  def next_date_for_weekday(weekday_number)
    Date.next_date_for_weekday(self, weekday_number)
  end

  def next_date_for_day_number(day_number)
    Date.next_date_for_day_number(self, day_number)
  end

  class << self
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
  end
end
