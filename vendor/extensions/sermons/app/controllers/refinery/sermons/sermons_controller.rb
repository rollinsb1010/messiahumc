module Refinery
  module Sermons
    class SermonsController < ::WorshippingController
      before_filter :find_all_sermons, :find_speakers, :sermons_by_date, :find_categories, :find_page

      def index
        @sermons = @sermons.paginate(params.slice(:page, :per_page))
        present(@page)
      end

      def by_category
        @sermon_category = SermonCategory.find(params[:id])
        @sermons = @sermon_category.sermons.paginate(params.slice(:page, :per_page))

        render 'index'
      end

      def show
        @sermon = Sermon.find(params[:id])
        present(@page)
      end

      protected

      def find_all_sermons
        @sermons = Sermon.recent
      end

      def find_categories
        @categories = SermonCategory.all
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
