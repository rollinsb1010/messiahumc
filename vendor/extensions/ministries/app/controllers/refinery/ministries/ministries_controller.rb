module Refinery
  module Ministries
    class MinistriesController < ::ApplicationController
      before_filter :find_all_ministry_categories, :find_highlighted_ministries, :find_page, :set_left_sidebar

      def index
        present(@page)
      end

      def show
        @ministry = Ministry.find(params[:id])

        present(@page)
      end

      def by_category
        @category = MinistryCategory.find(params[:id])

        size = @category.ministries.size
        middle = (size/2.0).ceil

        @left_ministries = @category.ministries[0...middle]
        @right_ministries = @category.ministries[middle..size]
      end

      protected

      def find_all_ministry_categories
        @left_ministry_categories = MinistryCategory.left
        @right_ministry_categories = MinistryCategory.right
      end

      def find_highlighted_ministries
        @left_highlighted_ministries = Ministry.highlighted.left
        @right_highlighted_ministries = Ministry.highlighted.right
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ministries").first
      end

      def set_left_sidebar
        left_sidebar = show_left_sidebar 'Ministry'
        MinistryCategory.all.each do |category|
          item = left_sidebar.add_item category.name, refinery.by_category_ministries_ministries_path(category)
          category.ministries.each { |ministry| item.add_item ministry.name, refinery.ministries_ministry_path(ministry) }
        end
      end
    end
  end
end
