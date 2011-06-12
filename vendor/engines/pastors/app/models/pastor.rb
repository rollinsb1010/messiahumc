class Pastor < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :what_i_do, :my_god_story, :education, :family, :hobbies]

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :photo, :class_name => 'Image'
end
