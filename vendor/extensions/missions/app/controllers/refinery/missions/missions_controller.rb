module Refinery
  module Missions
    class MissionsController < ::ApplicationController

      before_filter :find_all_missions
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @mission in the line below:
        present(@page)
      end

      def show
        @mission = Mission.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @mission in the line below:
        present(@page)
      end

    protected

      def find_all_missions
        @missions = Mission.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/missions").first
      end

    end
  end
end
