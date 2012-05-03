module Refinery
  module Missions
    class Mission < Refinery::Core::BaseModel
      self.table_name = 'refinery_missions'      
    
      acts_as_indexed :fields => [:name, :description]

      validates :name, :presence => true, :uniqueness => true
          
      belongs_to :logo, :class_name => '::Refinery::Image'
        
    end
  end
end
