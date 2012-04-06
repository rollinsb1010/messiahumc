module Refinery
  module Pastors
    class PastorsController < ::StaffController
      before_filter :find_all_pastors, :find_all_staff_members
      before_filter :find_page

      def index
        present(@page)
      end

      def show
        @pastor = Pastor.find(params[:id])

        present(@page)
      end

    protected

      def find_all_pastors
        if params[:id]
          @pastors = Pastor.where('id != ?', Pastor.find(params[:id]))
        else
          @pastors = Pastor.all
        end
        @pastors
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/pastors").first
      end

    end
  end
end
