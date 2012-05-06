module Refinery
  module Sermons
    class SermonCategory < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: :slugged

      self.table_name = 'refinery_sermon_categories'

      has_and_belongs_to_many :sermons, class_name: '::Refinery::Sermons::Sermon', join_table: 'refinery_sermons_sermon_categories', foreign_key: 'category_id', association_foreign_key: 'sermon_id'
    end
  end
end

