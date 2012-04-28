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

      def url
        ::Refinery::Core::Engine.routes.url_helpers.events_event_path(self)
      end

      def weekly?
        repeats == 'weekly'
      end

      def monthly?
        repeats == 'monthly'
      end

      def repeats?
        weekly? or monthly?
      end

      def next_date(context = Time.now.to_date)
        context = date if context < date

        return context.to_date.next_date_for_weekday(date.wday) if weekly?
        return context.to_date.next_date_for_day_number(date.day) if monthly?
        date
      end

      def dates_for_range(start_date, end_date)
        dates = [date]
        dates = Date.dates_for_weekday(start_date, end_date, date.wday) if weekly?
        dates = Date.dates_for_day_number(start_date, end_date, date.day) if monthly?

        dates
      end

      class << self
        def highlighted
          upcoming highlighted: true
        end

        def upcoming(conditions = {}, limit = 4)
          upcoming_events = {}

          current = Hash.new

          results = possible_since(Time.now.to_date, conditions).limit(limit)
          results.each { |event| current[event] = event.date.past? ? event.next_date : event.date }

          while upcoming_events.values.flatten.size < limit and current.any?
            current = sort current
            current_event, current_date = current.first

            add_event(upcoming_events, current_event, current_date)

            if current_event.repeats?
              current[current_event] = current_event.next_date (current_date + 1.day).to_date
            else
              current.shift
            end
          end

          upcoming_events
        end

        def for_date_range(start_date, end_date = start_date, conditions = {})
          events = {}
          return events if start_date > end_date

          start_date = start_date.to_date
          end_date = end_date.to_date

          results = possible_since(start_date, conditions).where { date <= end_date }

          results.each do |event|
            event.dates_for_range(start_date, end_date).each { |date| add_event(events, event, date) }
          end

          Hash[sorted(events)]
        end

        def possible_since(start_date, conditions = {})
          where { (repeats == 'monthly') | (repeats == 'weekly') | ((repeats == 'never') & (date >= start_date)) }.where(conditions)
        end

        private

        def sort(current)
          sorted = current.sort_by { |event, date_instance| [date_instance.to_datetime, event.start_time] }
          Hash[sorted]
        end

        def sorted(events)
          events.sort.map do |a|
            date, events = a
            [date, events.sort_by { |e| e.start_time or e.date.beginning_of_day }]
          end
        end

        def add_event(events, event, date)
          date = date.to_date
          events[date] ||= []
          events[date] << event
        end
      end
    end
  end
end
