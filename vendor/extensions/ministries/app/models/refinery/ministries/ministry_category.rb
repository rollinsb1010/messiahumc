module Refinery
  module Ministries
    class MinistryCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'

      self.table_name = 'refinery_ministry_categories'

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true
      validates :index_placement, presence: true, inclusion: {in: %w(left right)}

      has_many :ministries, foreign_key: 'ministry_category_id', dependent: :nullify

    end
  end
end
