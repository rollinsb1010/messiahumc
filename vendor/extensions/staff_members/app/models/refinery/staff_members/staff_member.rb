module Refinery
  module StaffMembers
    class StaffMember < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'

      self.table_name = 'refinery_staff_members'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]

      validates :name, presence: true, uniqueness: true
      validates :category, presence: true
      validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i}, allow_blank: true

      belongs_to :photo, class_name: '::Refinery::Image'

      belongs_to :category, class_name: '::Refinery::StaffMembers::StaffCategory'

    end
  end
end
