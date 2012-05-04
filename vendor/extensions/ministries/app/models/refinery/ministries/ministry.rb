module Refinery
  module Ministries
    class Ministry < ::SearchableModel
      extend Highlightable
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_ministries'

      default_scope order: 'position ASC'

      acts_as_indexed fields: [:name, :description]

      validates :name, presence: true, uniqueness: true
      validates :ministry_category, presence: true

      belongs_to :logo, class_name: '::Refinery::Image'
      belongs_to :center_image, class_name: '::Refinery::Image'
      belongs_to :ministry_category, foreign_key: 'ministry_category_id', class_name: '::Refinery::Ministries::MinistryCategory'
      has_many :events, class_name: '::Refinery::Events::Event'

      alias_attribute :title, :name

      def url
        ::Refinery::Core::Engine.routes.url_helpers.ministries_ministry_path(self.slug)
      end

      def summary
        description
      end

      def upcoming_events
        ::Refinery::Events::Event.upcoming ministry_id: id
      end

      class << self
        def left
          where ministry_category_id: ::Refinery::Ministries::MinistryCategory.left.pluck(:id)
        end

        def right
          where ministry_category_id: ::Refinery::Ministries::MinistryCategory.right.pluck(:id)
        end
      end
    end
  end
end
