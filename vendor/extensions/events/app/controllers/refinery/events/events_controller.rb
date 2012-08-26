module Refinery
  module Events
    class EventsController < ::ApplicationController
      before_filter :find_all_events, except: :index
      before_filter :filters, only: :index
      before_filter :find_page, :set_left_sidebar

      def index
        conditions = {}
        conditions[:ministry_id] = params[:ministries] if params[:ministries].present?
        @events = Event.for_date_range(@filters[:start_date], @filters[:end_date], conditions)
        present(@page)
      end

      def show
        @event = Event.find(params[:id])
        present(@page)
      end

      private

      def filters
        @filters = {
          start_date: (Chronic.parse(params[:start_date]) or Date.today),
          end_date: (Chronic.parse(params[:end_date]) or (Date.today + 6.days)),
          ministries: params[:ministries].present? ? ::Refinery::Ministries::Ministry.find(params[:ministries].reject(&:empty?)).map(&:name) : [],
          all_ministries: ::Refinery::Ministries::Ministry.all.map { |m| [m.name, m.id] }
        }
      end

      def find_all_events
        @events = Event.all
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: '/events').first
      end

      def set_left_sidebar
        left_sidebar = show_left_sidebar 'Events'

        calendar_item = left_sidebar.add_item 'Calendar', refinery.events_events_path
        left_sidebar.add_item 'Weekly Messenger', refinery.by_category_messengers_messengers_path('weekly')
        left_sidebar.add_item 'Monthly Messenger', refinery.by_category_messengers_messengers_path('monthly')

        calendar_item.add_item(@event.name, refinery.events_event_path(@event)) if @event.present?
      end
    end
  end
end
