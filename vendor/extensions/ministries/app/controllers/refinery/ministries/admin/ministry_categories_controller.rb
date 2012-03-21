module Refinery
  module Ministries
    module Admin
      class MinistryCategoriesController < ::Refinery::AdminController

        crudify :'refinery/ministries/ministry_category', title_attribute: 'name', xhr_paging: true

      end
    end
  end
end
