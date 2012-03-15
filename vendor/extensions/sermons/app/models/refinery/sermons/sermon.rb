module Refinery
  module Sermons
    class Sermon < Refinery::Core::BaseModel
      default_scope order: 'position ASC'
      self.table_name = 'refinery_sermons'      
    
      acts_as_indexed :fields => [:title, :location, :description, :scripture_reading]

      validates :title, :presence => true, :uniqueness => true
          
      belongs_to :image, :class_name => '::Refinery::Image'
        
      belongs_to :mp3_file, :class_name => '::Refinery::Resource'
    
    end
  end
end
