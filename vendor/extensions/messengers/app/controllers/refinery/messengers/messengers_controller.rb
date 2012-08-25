module Refinery
  module Messengers
    class MessengersController < ::ApplicationController

      before_filter :find_all_messengers
      before_filter :find_page
      before_filter :set_left_sidebar

      def index
        present(@page)
      end

      def by_category
        if params[:id] == 'monthly'
          @messengers = @monthly_messengers
          @name = 'Monthly'
        else
          @messengers = @weekly_messengers
          @name = 'Weekly'
        end
      end

    protected

      def find_all_messengers
        @weekly_messengers = Messenger.weekly
        @monthly_messengers = Messenger.monthly
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/messengers").first
      end

      def set_left_sidebar
        left_sidebar = show_left_sidebar 'Messengers'
        left_sidebar.add_item 'Weekly', refinery.by_category_messengers_messengers_path('weekly')
        left_sidebar.add_item 'Monthly', refinery.by_category_messengers_messengers_path('monthly')
      end

    end
  end
end
