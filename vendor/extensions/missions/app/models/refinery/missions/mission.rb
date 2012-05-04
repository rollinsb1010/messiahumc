module Refinery
  module Missions
    class Mission < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_missions'

      acts_as_indexed fields: [:name, :description]

      validates :name, presence: true, uniqueness: true

      belongs_to :logo, class_name: '::Refinery::Image'
      belongs_to :category, class_name: '::Refinery::Missions::MissionCategory'

      class << self
        def highlighted
          where(highlighted: true)
        end

        def left
          where('category_id IN (?)', MissionCategory.left.pluck(:id))
        end

        def right
          where('category_id IN (?)', MissionCategory.right.pluck(:id))
        end
      end
    end
  end
end
