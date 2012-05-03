module Refinery
  module Sermons
    class SermonsController < ::WorshippingController
      before_filter :find_all_sermons, :find_speakers, :sermons_by_date, :find_page

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

      def find_speakers
        @speakers = @sermons.map(&:pastor).uniq
      end

      def sermons_by_date
        @by_date = Sermon.by_date
      end
    end
  end
end
