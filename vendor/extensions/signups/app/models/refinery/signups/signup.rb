module Refinery
  module Signups
    class Signup < Refinery::Core::BaseModel
      has_many :signup_slots, :dependent => :destroy
      has_many :participants, :dependent => :destroy
      accepts_nested_attributes_for :signup_slots, :reject_if => lambda {|slot| slot[:description].blank? || slot[:available_slots].blank? }, :allow_destroy => true

      self.table_name = 'refinery_signups'

      attr_accessible :name, :slug, :description, :responsible_name, :responsible_email, :responsible_phone, :dates, :times, :position, :signup_slots_attributes

      acts_as_indexed :fields => [:name, :description, :responsible_name, :responsible_email, :responsible_phone, :dates, :times]

      validates :name, :presence => true, :uniqueness => true
    end

    class SignupSlot < Refinery::Core::BaseModel
      belongs_to :signup
      has_many :participants
      self.table_name = 'refinery_signup_slots'
      attr_accessible :description, :available_slots, :refinery_signup_id
      validates :description, :available_slots, :presence => true
    end

    class Participant < Refinery::Core::BaseModel
      belongs_to :signup
      belongs_to :signup_slot
      self.table_name = 'refinery_participants'
      attr_accessible :name, :email, :phone, :signup_slot_id, :signup_id
      validates :name, :signup_id, :presence => true
    end
  end
end
