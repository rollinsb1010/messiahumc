module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :get_ministries
        before_filter :parse_date, only: [:update, :create]
        helper :events

        crudify :'refinery/events/event', xhr_paging: true
        
        def include_repeating?
          @include_repeating = params[:repeating] == 'yes'
          @include_repeating ? { } : { repeats: 'never' }
        end

        def get_ministries
          @ministries = ::Refinery::Ministries::Ministry.all
        end

        def parse_date
          params[:event][:date] = Chronic.parse(params[:event][:date])
        end

        def find_all_events
          @events = Event.where(include_repeating?).order("date ASC")
        end

      end
    end
  end
end
