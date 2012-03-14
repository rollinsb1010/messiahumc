module Refinery
  module StaffMembers
    class StaffCategory < Refinery::Core::BaseModel
      self.table_name = 'refinery_staff_categories'

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true

      has_many :staff_members, foreign_key: 'category_id'
    end
  end
end

