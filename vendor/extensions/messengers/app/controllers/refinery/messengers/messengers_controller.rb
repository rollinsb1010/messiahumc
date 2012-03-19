module Refinery
  module Messengers
    class MessengersController < ::ApplicationController

      before_filter :find_all_messengers
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @messenger in the line below:
        present(@page)
      end

      def show
        @messenger = Messenger.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @messenger in the line below:
        present(@page)
      end

    protected

      def find_all_messengers
        @messengers = Messenger.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/messengers").first
      end

    end
  end
end
