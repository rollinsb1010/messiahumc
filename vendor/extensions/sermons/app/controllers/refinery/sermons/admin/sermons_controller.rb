module Refinery
  module Sermons
    module Admin
      class SermonsController < ::Refinery::AdminController

        crudify :'refinery/sermons/sermon', :xhr_paging => true

      end
    end
  end
end
