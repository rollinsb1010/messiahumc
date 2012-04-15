module Refinery
  module Events
    class EventsController < ::ApplicationController
      before_filter :find_all_events, :find_page, :set_left_sidebar

      def index
        present(@page)
      end

      def show
        @event = Event.find(params[:id])
        present(@page)
      end

      protected
      def find_all_events
        @events = Event.all
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: '/events').first
      end

      def set_left_sidebar
        left_sidebar = show_left_sidebar 'Events'

        left_sidebar.add_item 'Upcoming Events', '#'
        calendar_item = left_sidebar.add_item 'Calendar', refinery.events_events_path
        left_sidebar.add_item 'Weekly Messenger', '#'
        left_sidebar.add_item 'Monthly Messenger', '#'

        calendar_item.add_item(@event.name, refinery.events_event_path(@event)) if @event.present?
      end
    end
  end
end
