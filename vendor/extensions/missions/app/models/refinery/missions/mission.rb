module Refinery
  module Missions
    class Mission < Refinery::Core::BaseModel
      extend Highlightable
      extend FriendlyId
      friendly_id :name, use: :slugged
      scope :matching, lambda {|search_term| where("name ~* ? or description ~* ?", search_term, search_term)}

      self.table_name = 'refinery_missions'

      acts_as_indexed fields: [:name, :description]

      validates :name, presence: true, uniqueness: true

      belongs_to :logo, class_name: '::Refinery::Image'
      belongs_to :category, class_name: '::Refinery::Missions::MissionCategory'

      class << self
        def left
          where mission_category_id: ::Refinery::Missions::MissionCategory.left.pluck(:id)
        end

        def right
          where mission_category_id: ::Refinery::Missions::MissionCategory.right.pluck(:id)
        end
      end
    end
  end
end
