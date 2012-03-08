module Refinery
  module Sermons
    class SermonsController < ::ApplicationController

      before_filter :find_all_sermons
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @sermon in the line below:
        present(@page)
      end

      def show
        @sermon = Sermon.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @sermon in the line below:
        present(@page)
      end

    protected

      def find_all_sermons
        @sermons = Sermon.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/sermons").first
      end

    end
  end
end
