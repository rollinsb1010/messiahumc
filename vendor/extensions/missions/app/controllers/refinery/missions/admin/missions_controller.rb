module Refinery
  module Missions
    module Admin
      class MissionsController < ::Refinery::AdminController
        before_filter :get_mission_categories

        crudify :'refinery/missions/mission', title_attribute: 'name', xhr_paging: true

        def get_mission_categories
          @mission_categories = ::Refinery::Missions::MissionCategory.all
        end
      end
    end
  end
end
