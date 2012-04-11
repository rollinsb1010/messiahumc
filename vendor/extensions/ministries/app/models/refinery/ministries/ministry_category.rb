module Refinery
  module Ministries
    class MinistryCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_ministry_categories'

      default_scope order: 'position ASC'

      acts_as_indexed fields: [:name]

      validates :name, presence: true, uniqueness: true
      validates :index_placement, presence: true, inclusion: {in: %w(left right)}

      has_many :ministries, foreign_key: 'ministry_category_id', class_name: '::Refinery::Ministries::Ministry', dependent: :nullify

      def highlighted_ministries
        self.ministries.select{highlighted = true}
      end

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
