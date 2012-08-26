class YouthController < YouthfulController
  def index
    @page = ::Refinery::Page.where(slug: 'youth').first
    present(@page)
  end

  def show
    @page = ::Refinery::Page.find_by_path_or_id(params[:path], params[:id])
    present(@page)
  end

end
