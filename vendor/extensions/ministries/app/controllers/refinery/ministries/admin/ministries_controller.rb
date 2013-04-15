module Refinery
  module Ministries
    module Admin
      class MinistriesController < ::Refinery::AdminController
        before_filter :get_ministry_categories

        crudify :'refinery/ministries/ministry', title_attribute: 'name', xhr_paging: true

        def get_ministry_categories
          @ministry_categories = ::Refinery::Ministries::MinistryCategory.all
        end

        def search_all_ministries(search_term = nil)
          @ministries = Ministry.matching(params[:search])
        end
      end
    end
  end
end
