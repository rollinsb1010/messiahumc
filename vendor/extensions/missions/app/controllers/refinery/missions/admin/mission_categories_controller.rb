module Refinery
  module Missions
    module Admin
      class MissionCategoriesController < ::Refinery::AdminController

        crudify :'refinery/missions/mission_category', title_attribute: 'name', xhr_paging: true

      end
    end
  end
end
