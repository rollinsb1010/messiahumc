class Pastor < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :job_title, :bio, :email]
  alias_attribute :title, :name

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :thumbnail, :class_name => 'Image'
  belongs_to :large_photo, :class_name => 'Image'
end
