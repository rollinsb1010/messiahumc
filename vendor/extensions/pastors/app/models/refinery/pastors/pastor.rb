module Refinery
  module Pastors
    class Pastor < Refinery::Core::BaseModel
      extend FriendlyId
      include ::Person
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'

      self.table_name = 'refinery_pastors'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]
      alias_attribute :title, :name

      validates :name, presence: true, uniqueness: true
      validates :email, email: true

      belongs_to :photo, class_name: '::Refinery::Image'

      def pastor?
        true
      end
    end
  end
end
