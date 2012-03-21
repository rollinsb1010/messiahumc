module Refinery
  module Ministries
    class MinistriesController < ::ApplicationController

      before_filter :find_all_ministries, only: [:index]
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ministry in the line below:
        present(@page)
      end

      def show
        @ministry = Ministry.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ministry in the line below:
        present(@page)
      end

    protected

      def find_all_ministries
        @left_ministries = MinistryCategory.left
        @right_ministries = MinistryCategory.right
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ministries").first
      end

    end
  end
end
