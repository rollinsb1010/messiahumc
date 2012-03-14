module Refinery
  module StaffMembers
    class StaffMember < Refinery::Core::BaseModel
      default_scope order: 'position ASC'

      self.table_name = 'refinery_staff_members'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]

      validates :name, presence: true, uniqueness: true
      validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i

      belongs_to :photo, class_name: '::Refinery::Image'

      belongs_to :category, class_name: '::Refinery::StaffMembers::StaffCategory'

    end
  end
end
