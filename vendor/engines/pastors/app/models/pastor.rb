class Pastor < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :job_title, :bio, :email]

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :thumbnail, :class_name => 'Image'
  belongs_to :large_photo, :class_name => 'Image'
end
