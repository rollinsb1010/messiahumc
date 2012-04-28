module Refinery
  module StaffMembers
    class StaffMember < Refinery::Core::BaseModel
      extend FriendlyId
      include ::Person
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'

      self.table_name = 'refinery_staff_members'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]

      validates :name, presence: true, uniqueness: true
      validates :category, presence: true
      validates :email, email: true

      belongs_to :photo, class_name: '::Refinery::Image'

      belongs_to :category, class_name: '::Refinery::StaffMembers::StaffCategory'

      def url
        ::Refinery::Core::Engine.routes.url_helpers.staff_members_staff_member_path(self)
      end
    end
  end
end
