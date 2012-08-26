class WorshipController < WorshippingController
  before_filter :find_page

  def index
    present(@page)
  end

  def show
    @page = ::Refinery::Page.find_by_path_or_id(params[:path], params[:id])
    present(@page)
  end

  protected
  def find_page
    @page = ::Refinery::Page.where(menu_match: '^/worship$').first
  end
end
