module Refinery
  module Ministries
    module Admin
      class MinistriesController < ::Refinery::AdminController
        before_filter :get_ministry_categories

        crudify :'refinery/ministries/ministry', title_attribute: 'name', xhr_paging: true

        def get_ministry_categories
          @ministry_categories = ::Refinery::Ministries::MinistryCategory.all
        end
      end
    end
  end
end
