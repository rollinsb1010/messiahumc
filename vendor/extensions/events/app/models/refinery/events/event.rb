module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      self.table_name = 'refinery_events'
      extend FriendlyId
      friendly_id :title, use: :slugged

      acts_as_indexed fields: [:title, :repetition, :location, :short_description, :long_description, :contact_name, :contact_email, :contact_phone, :notes]

      validates :title, presence: true, uniqueness: true

      belongs_to :image, class_name: '::Refinery::Image'

    end
  end
end
