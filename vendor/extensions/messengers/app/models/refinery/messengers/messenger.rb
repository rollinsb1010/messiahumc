module Refinery
  module Messengers
    class Messenger < Refinery::Core::BaseModel
      self.table_name = 'refinery_messengers'      
    
      acts_as_indexed :fields => [:messenger_type]

      validates :messenger_type, :presence => true, :uniqueness => true
              
      belongs_to :pdf_file, :class_name => '::Refinery::Resource'
    
    end
  end
end
