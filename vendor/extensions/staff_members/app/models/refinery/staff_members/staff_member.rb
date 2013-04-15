module Refinery
  module StaffMembers
    class StaffMember < ::SearchableModel
      extend FriendlyId
      include ::Person
      friendly_id :name, use: :slugged

      default_scope order: 'position ASC'
      scope :matching, lambda {|search_term| where("name ~* ? or job_title ~* ?", search_term, search_term)}

      self.table_name = 'refinery_staff_members'

      acts_as_indexed fields: [:name, :job_title, :bio, :email]
      alias_attribute :title, :name

      validates :name, presence: true, uniqueness: true
      validates :category, presence: true
      validates :email, email: true

      belongs_to :photo, class_name: '::Refinery::Image'

      belongs_to :category, class_name: '::Refinery::StaffMembers::StaffCategory'

      def url
        ::Refinery::Core::Engine.routes.url_helpers.staff_members_staff_member_path(self.slug)
      end

      def summary
        bio
      end
    end
  end
end
