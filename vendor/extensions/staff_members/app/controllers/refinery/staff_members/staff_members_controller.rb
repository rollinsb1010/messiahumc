module Refinery
  module StaffMembers
    class StaffMembersController < ::ApplicationController

      before_filter :find_all_staff_members
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @staff_member in the line below:
        present(@page)
      end

      def show
        @staff_member = StaffMember.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @staff_member in the line below:
        present(@page)
      end

    protected

      def find_all_staff_members
        @right_categories = []
        @left_categories = [
          {
            name: 'Pastors',
            members: ::Refinery::Pastors::Pastor.all,
            url: lambda { |p| refinery.pastors_pastor_path(p) },
          }
        ]
        StaffCategory.where(index_placement: 'left').each { |c| @left_categories << get_staff_category(c) }
        StaffCategory.where(index_placement: 'right').each { |c| @right_categories << get_staff_category(c) }
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/staff_members").first
      end

      def get_staff_category(category)
        {
          name: category.name,
          members: category.staff_members,
          url: lambda { |s| refinery.staff_members_staff_member_path(s) },
        }
      end

    end
  end
end
