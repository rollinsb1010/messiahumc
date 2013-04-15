module Refinery
  module StaffMembers
    module Admin
      class StaffMembersController < ::Refinery::AdminController
        before_filter :get_staff_categories

        crudify :'refinery/staff_members/staff_member', title_attribute: 'name', xhr_paging: true

        def get_staff_categories
          @staff_categories = ::Refinery::StaffMembers::StaffCategory.all
        end

        def search_all_staff_members(search_term = nil)
          @staff_members = StaffMember.matching(params[:search])
        end
      end
    end
  end
end
