module Refinery
  module Sermons
    class Sermon < Refinery::Core::BaseModel
      default_scope order: 'position ASC'

      self.table_name = 'refinery_sermons'

      acts_as_indexed :fields => [:speaker, :title]

      validates :speaker, :presence => true, :uniqueness => true

    end
  end
end
