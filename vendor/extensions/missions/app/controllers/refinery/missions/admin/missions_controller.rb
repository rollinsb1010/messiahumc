module Refinery
  module Missions
    module Admin
      class MissionsController < ::Refinery::AdminController

        crudify :'refinery/missions/mission',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
