module Refinery
  module StaffMembers
    module Admin
      class StaffCategoriesController < ::Refinery::AdminController

        crudify :'refinery/staff_members/staff_category', title_attribute: 'name', xhr_paging: true

      end
    end
  end
end
