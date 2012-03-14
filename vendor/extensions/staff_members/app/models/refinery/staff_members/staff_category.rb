module Refinery
  module StaffMembers
    class StaffCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'

      self.table_name = 'refinery_staff_categories'

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true
      validates :index_placement, presence: true, inclusion: {in: %w(left right)}

      has_many :staff_members, foreign_key: 'category_id', dependent: :nullify
    end
  end
end

