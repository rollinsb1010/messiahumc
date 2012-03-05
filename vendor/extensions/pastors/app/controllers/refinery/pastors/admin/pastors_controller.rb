module Refinery
  module Pastors
    module Admin
      class PastorsController < ::Refinery::AdminController

        crudify :'refinery/pastors/pastor',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
