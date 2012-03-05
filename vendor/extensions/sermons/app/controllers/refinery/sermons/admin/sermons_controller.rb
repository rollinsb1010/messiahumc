module Refinery
  module Sermons
    module Admin
      class SermonsController < ::Refinery::AdminController

        crudify :'refinery/sermons/sermon',
                :title_attribute => 'speaker', :xhr_paging => true

      end
    end
  end
end
