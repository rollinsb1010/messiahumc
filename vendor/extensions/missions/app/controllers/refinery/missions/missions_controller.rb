module Refinery
  module Missions
    class MissionsController < ::ApplicationController
      before_filter :find_all_mission_categories, :find_highlighted_missions, :find_page, :set_left_sidebar

      def index
        present(@page)
      end

      def by_category
        @category = MissionCategory.find(params[:id])

        size = @category.missions.size
        middle = (size/2.0).ceil

        @left_missions = @category.missions[0...middle]
        @right_missions = @category.missions[middle..size]
      end

      def show
        @mission = Mission.find(params[:id])
        present(@page)
      end

      protected

      def find_all_mission_categories
        @left_mission_categories = MissionCategory.left
        @right_mission_categories = MissionCategory.right
      end

      def find_highlighted_missions
        @left_highlighted_missions = Mission.highlighted.left
        @right_highlighted_missions = Mission.highlighted.right
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/missions").first
      end

      def set_left_sidebar
        left_sidebar = show_left_sidebar 'Missions'

        MissionCategory.all.each do |category|
          left_sidebar.add_item category.name, refinery.by_category_missions_missions_path(category)
        end
      end
    end
  end
end
