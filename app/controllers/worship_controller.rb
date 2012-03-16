class WorshipController < ApplicationController
  before_filter :find_page

  def index
    present(@page)
  end

  protected
  def find_page
    @page = ::Refinery::Page.where(menu_match: '^/worship$').first
  end
end
