module Refinery
  module Signups
    class SignupsController < ::ApplicationController

      before_filter :find_all_signups
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @signup in the line below:
        present(@page)
      end

      def show
        @signup = Signup.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @signup in the line below:
        present(@page)
      end

    protected

      def find_all_signups
        @signups = Signup.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/signups").first
      end

    end
  end
end