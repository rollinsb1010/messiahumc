module Refinery
  module Sermons
    class SermonsController < ::WorshippingController
      before_filter :find_all_sermons
      before_filter :find_page

      def index
        present(@page)
      end

      def show
        @sermon = Sermon.find(params[:id])

        present(@page)
      end

      protected

      def find_all_sermons
        @sermons = Sermon.recent
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: '/sermons').first
      end
    end
  end
end
