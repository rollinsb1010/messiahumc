module Refinery
  module StaffMembers
    class StaffMembersController < ::StaffController

      before_filter :find_all_staff_members, only: [:index]
      before_filter :find_page

      def index
        present(@page)
      end

      def show
        @staff_member = StaffMember.find(params[:id])

        present(@page)
      end

    protected

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/staff_members").first
      end


    end
  end
end
