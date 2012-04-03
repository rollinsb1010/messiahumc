module Refinery
  module Ministries
    class Ministry < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_ministries'

      default_scope order: 'position ASC'

      acts_as_indexed fields: [:name, :description]

      validates :name, presence: true, uniqueness: true
      validates :ministry_category, presence: true

      belongs_to :logo, class_name: '::Refinery::Image'
      belongs_to :ministry_category, foreign_key: 'ministry_category_id', class_name: '::Refinery::Ministries::MinistryCategory'

    end
  end
end