module Refinery
  module Messengers
    class MessengersController < ::ApplicationController

      before_filter :find_all_messengers
      before_filter :find_page

      def index
        present(@page)
      end

    protected

      def find_all_messengers
        @weekly_messengers = Messenger.weekly
        @monthly_messengers = Messenger.monthly
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/messengers").first
      end

    end
  end
end
