module Refinery
  module Ministries
    module Admin
      class MinistriesController < ::Refinery::AdminController

        crudify :'refinery/ministries/ministry',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
