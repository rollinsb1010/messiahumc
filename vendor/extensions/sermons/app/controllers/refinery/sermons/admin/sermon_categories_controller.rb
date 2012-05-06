module Refinery
  module Sermons
    module Admin
      class SermonCategoriesController < ::Refinery::AdminController

        crudify :'refinery/sermons/sermon_category', title_attribute: 'name', xhr_paging: true

      end
    end
  end
end
