module Refinery
  module Ministries
    class MinistriesController < ::ApplicationController
      before_filter :find_all_ministry_categories, :find_highlighted_ministries
      before_filter :find_page

      def index
        present(@page)
      end

      def show
        @ministry = Ministry.find(params[:id])

        present(@page)
      end

      def by_category
        @category = MinistryCategory.find(params[:id])
      end

      protected

      def find_all_ministry_categories
        @left_ministry_categories = MinistryCategory.left
        @right_ministry_categories = MinistryCategory.right
        @all_ministry_categories = MinistryCategory.all
      end

      def find_highlighted_ministries
        @left_highlighted_ministries = Ministry.highlighted.left
        @right_highlighted_ministries = Ministry.highlighted.right
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ministries").first
      end
    end
  end
end
