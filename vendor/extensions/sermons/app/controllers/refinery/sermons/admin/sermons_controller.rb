module Refinery
  module Sermons
    module Admin
      class SermonsController < ::Refinery::AdminController
        before_filter :get_pastors

        crudify :'refinery/sermons/sermon', xhr_paging: true

        def get_pastors
          @pastors = ::Refinery::Pastors::Pastor.all
        end
      end
    end
  end
end
