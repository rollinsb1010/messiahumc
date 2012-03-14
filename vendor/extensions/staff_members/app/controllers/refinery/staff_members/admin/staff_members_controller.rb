module Refinery
  module StaffMembers
    module Admin
      class StaffMembersController < ::Refinery::AdminController

        crudify :'refinery/staff_members/staff_member',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
