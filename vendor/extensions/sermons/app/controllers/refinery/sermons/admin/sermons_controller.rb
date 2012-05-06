module Refinery
  module Sermons
    module Admin
      class SermonsController < ::Refinery::AdminController
        before_filter :get_pastors, :get_default_date, :get_sermon_categories

        crudify :'refinery/sermons/sermon', xhr_paging: true

        def get_pastors
          @pastors = ::Refinery::Pastors::Pastor.all
        end

        def get_default_date
          today = Time.now
          if today.sunday?
            @default_date = today
          else
            @default_date = ::Chronic.parse('last sunday')
          end
        end

        def get_sermon_categories
          @sermon_categories = ::Refinery::Sermons::SermonCategory.all
        end
      end
    end
  end
end
