module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :get_ministries
        before_filter :parse_date, only: [:update, :create]
        helper :events

        crudify :'refinery/events/event', xhr_paging: true

        def get_ministries
          @ministries = ::Refinery::Ministries::Ministry.all
        end

        def parse_date
          params[:event][:date] = Chronic.parse(params[:event][:date])
        end
      end
    end
  end
end
