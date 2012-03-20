module Refinery
  module Messengers
    class Messenger < Refinery::Core::BaseModel
      self.table_name = 'refinery_messengers'

      default_scope order: 'published_at desc'
      scope :published, where('published_at < ?', Time.now)
      scope :weekly, published.where(messenger_type: 'weekly')
      scope :monthly, published.where(messenger_type: 'monthly')

      validates :messenger_type, presence: true
      validates :published_at, presence: true
      validates :pdf_file_id, presence: true

      belongs_to :pdf_file, class_name: '::Refinery::Resource'

      def title
        "#{messenger_type.titleize} Messenger - #{published_at.strftime('%-m/%-d/%Y')}"
      end
    end
  end
end
