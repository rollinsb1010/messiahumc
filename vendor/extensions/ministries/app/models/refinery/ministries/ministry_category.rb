module Refinery
  module Ministries
    class MinistryCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_ministry_categories'

      default_scope order: 'position ASC'
      scope :left, where(index_placement: 'left')
      scope :right, where(index_placement: 'right')

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true
      validates :index_placement, presence: true, inclusion: {in: %w(left right)}

      has_many :ministries, foreign_key: 'ministry_category_id', class_name: '::Refinery::Ministries::Ministry', dependent: :nullify

    end
  end
end
