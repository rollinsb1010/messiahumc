class PastorsController < ApplicationController

  before_filter :find_all_pastors
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @pastor in the line below:
    present(@page)
  end

  def show
    @pastor = Pastor.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @pastor in the line below:
    present(@page)
  end

protected

  def find_all_pastors
    @pastors = Pastor.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/pastors").first
  end

end
