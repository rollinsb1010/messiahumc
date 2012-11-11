module Refinery
  module Signups
    class Signup < Refinery::Core::BaseModel
      self.table_name = 'refinery_signups'

      attr_accessible :name, :description, :responsible_name, :responsible_email, :responsible_phone, :dates, :times, :position

      acts_as_indexed :fields => [:name, :description, :responsible_name, :responsible_email, :responsible_phone, :dates, :times]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
