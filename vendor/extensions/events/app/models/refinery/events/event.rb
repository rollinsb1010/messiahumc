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
          weekly = weekly.select { |e| (e.date.wday >= start_date.wday) or (e.date.wday <= end_date.wday) } unless (end_date - start_date >= 7)

          day = Date.today
          events[day] ||= []
          weekly.each { |event| events[day] << event }

          in_range.each do |event|
            events[event.date] ||= []
            events[event.date] << event
          end

          events
        end
      end
    end
  end
end
