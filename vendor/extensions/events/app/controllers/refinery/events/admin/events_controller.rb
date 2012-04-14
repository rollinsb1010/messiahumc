module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :get_ministries

        crudify :'refinery/events/event', xhr_paging: true

        def get_ministries
          @ministries = ::Refinery::Ministries::Ministry.all
        end
      end
    end
  end
end
