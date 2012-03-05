class Sermon < ActiveRecord::Base

  acts_as_indexed :fields => [:speaker, :title]

  validates :speaker, :presence => true, :uniqueness => true
  
end
