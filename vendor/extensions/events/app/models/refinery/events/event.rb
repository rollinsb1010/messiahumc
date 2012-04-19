module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      self.table_name = 'refinery_events'

      extend FriendlyId
      friendly_id :title, use: :slugged

      default_scope order('date ASC')

      acts_as_indexed fields: [:title, :repeats, :location, :short_description, :long_description, :contact_name, :contact_email, :contact_phone, :notes]

      validates :title, presence: true, uniqueness: true
      validates :date, presence: true
      validates :repeats, presence: true, inclusion: {in: %w(never weekly monthly)}
      validates :short_description, presence: true
      validates :long_description, presence: true
      validates :contact_email, email: true

      belongs_to :image, class_name: '::Refinery::Image'
      belongs_to :ministry, foreign_key: 'ministry_id', class_name: '::Refinery::Ministries::Ministry'

      def in_range?(start_date, end_date)
        date >= start_date and date <= end_date
      end

      class << self
        def upcoming
          where('date >= ?', Date.today).limit(5)
        end

        def for_date_range(start_date, end_date)
          events = {}
          return events if start_date > end_date

          start_date = start_date.to_date
          end_date = end_date.to_date

          in_range = where('date >= ? AND date <= ?', start_date, end_date)
          weekly = where('date <= ? AND repeats = ?', end_date, 'weekly')
          monthly = where('date <= ? AND repeats = ?', end_date, 'monthly')

          weekly.each do |event|
            dates = dates_for_weekday(start_date, end_date, event.date.wday)
            dates.each { |date| add_event(events, event, date) }
          end

          monthly.each do |event|
            dates = dates_for_day_number(start_date, end_date, event.date.day)
            dates.each { |date| add_event(events, event, date) }
          end

          in_range.each { |event| add_event(events, event, event.date) }

          events
        end

        def add_event(events, event, date)
          date = date.to_date
          events[date] ||= []
          events[date] << event
        end

        private

        def dates_for_weekday(start_date, end_date, weekday_number)
          dates = []
          current_date = start_date

          while current_date <= end_date
            dates << current_date if current_date.wday == weekday_number
            current_date = Chronic.parse("next #{Date::DAYNAMES[weekday_number]}", now: current_date)
          end

          dates
        end

        def dates_for_day_number(start_date, end_date, day_number)
          dates = []
          current_date = Chronic.parse("#{Date::MONTHNAMES[start_date.month]} #{day_number}")
          current_date = next_date_for_day_number(start_date, day_number) if current_date.nil? or current_date < start_date

          while current_date <= end_date
            dates << current_date if current_date.day == day_number
            current_date = next_date_for_day_number(current_date, day_number)
          end

          dates
        end

        def next_date_for_day_number(initial_date, day_number)
          next_date = nil
          number = 1

          while next_date.nil? and number <= 12
            next_date = Chronic.parse("#{Date::MONTHNAMES[(initial_date + number.months).month]} #{day_number}")
            number += 1
          end

          next_date.to_date
        end
      end
    end
  end
end
