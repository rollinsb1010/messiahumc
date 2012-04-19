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

          weekly.each do |event|
            dates = get_all_dates_for_weekday(start_date, end_date, event.date.wday)
            dates.each { |date| add_event(events, event, date) }
          end

          in_range.each { |event| add_event(events, event, event.date) }

          events
        end

        def add_event(events, event, date)
          events[date] ||= []
          events[date] << event
        end

        private

        def get_all_dates_for_weekday(start_date, end_date, weekday_number)
          dates = []
          current_date = start_date

          while current_date <= end_date
            dates << current_date if current_date.wday == weekday_number
            current_date = Chronic.parse("next #{Date::DAYNAMES[weekday_number]}", now: current_date).to_date
          end

          dates
        end
      end
    end
  end
end
