module Refinery
  module StaffMembers
    class StaffMember < Refinery::Core::BaseModel
      self.table_name = 'refinery_staff_members'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]

      validates :name, presence: true, uniqueness: true

      belongs_to :photo, class_name: '::Refinery::Image'
      
      belongs_to :category

    end
  end
end
