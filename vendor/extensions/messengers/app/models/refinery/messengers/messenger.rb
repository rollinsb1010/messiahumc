module Refinery
  module Messengers
    class Messenger < Refinery::Core::BaseModel
      self.table_name = 'refinery_messengers'

      default_scope order: 'published_at desc'

      acts_as_indexed fields: [:messenger_type]

      scope :published, where('published_at < ?', Time.now)
      scope :for_last_calendar_year, published.where('published_at > ?', 1.year.ago)

      scope :weekly, for_last_calendar_year.where(messenger_type: 'weekly')
      scope :monthly, for_last_calendar_year.where(messenger_type: 'monthly')

      validates :messenger_type, presence: true, inclusion: {in: %(weekly monthly)}
      validates :published_at, presence: true
      #validates :pdf_file_id, presence: true

      belongs_to :pdf_file, class_name: '::Refinery::Resource'

      def title
        "#{messenger_type.titleize} Messenger - #{published_at.strftime('%-m/%-d/%Y')}"
      end

      def url
        ::Refinery::Core::Engine.routes.url_helpers.messengers_messenger_path(self)
      end

      def summary
        title
      end
    end
  end
end
