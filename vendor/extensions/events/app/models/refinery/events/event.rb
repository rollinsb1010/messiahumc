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

      def weekly?
        repeats == 'weekly'
      end

      def monthly?
        repeats == 'monthly'
      end

      def next_date(context = Time.now.to_date)
        context = date if context < date

        return context.to_date.next_date_for_weekday(date.wday) if weekly?
        return context.to_date.next_date_for_day_number(date.day) if monthly?
        date
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

            current_event = current.first[0]
            current_date = current.first[1]

            add_event(upcoming_events, current_event, current_date)

            if current_event.repeats == 'never'
              current.shift
            else
              current[current_event] = current_event.next_date((current_date + 1.day).to_date)
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
            dates = [event.date]
            dates = Date.dates_for_weekday(start_date, end_date, event.date.wday) if event.weekly?
            dates = Date.dates_for_day_number(start_date, end_date, event.date.day) if event.monthly?

            dates.each { |date| add_event(events, event, date) }
          end

          Hash[sorted(events)]
        end

        def possible_since(start_date, conditions = {})
          where { (repeats == 'monthly') | (repeats == 'weekly') | ((repeats == 'never') & (date >= start_date)) }.where(conditions)
        end

        private

        def sort(current)
          sorted = current.sort_by do |event, date_instance|
            value = date_instance.to_datetime
            value += (event.start_time.seconds_since_midnight).seconds if event.start_time.present?

            value
          end

          Hash[sorted]
        end

        def sorted(events)
          events.sort.map do |a|
            date, events = a
            sorted_events = events.sort_by { |e| e.start_time or e.date.beginning_of_day }
            [date, sorted_events]
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
