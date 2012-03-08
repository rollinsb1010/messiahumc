module Refinery
  module Sermons
    class Sermon < Refinery::Core::BaseModel
      self.table_name = 'refinery_sermons'      
    
      acts_as_indexed :fields => [:speaker, :title]

      validates :speaker, :presence => true, :uniqueness => true
              
    end
  end
end
