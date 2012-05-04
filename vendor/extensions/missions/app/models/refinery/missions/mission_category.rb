module Refinery
  module Missions
    class MissionCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_mission_categories'

      default_scope order: 'position ASC'

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true
      validates :index_placement, presence: true, inclusion: {in: %w(left right)}

      has_many :missions, foreign_key: 'category_id', class_name: '::Refinery::Missions::Mission', dependent: :nullify

      class << self
        def left
          where(index_placement: 'left')
        end

        def right
          where(index_placement: 'right')
        end
      end
    end
  end
end

