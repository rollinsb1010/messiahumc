module Refinery
  module Pastors
    class Pastor < Refinery::Core::BaseModel
      default_scope order: 'position ASC'

      self.table_name = 'refinery_pastors'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]
      alias_attribute :title, :name

      validates :name, presence: true, uniqueness: true

      belongs_to :thumbnail, class_name: '::Refinery::Image'

      belongs_to :large_photo, class_name: '::Refinery::Image'

    end
  end
end
