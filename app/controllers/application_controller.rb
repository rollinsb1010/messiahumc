class ApplicationController < ActionController::Base
  before_filter :set_pagination_defaults
  protect_from_forgery
  layout 'general'

  def set_pagination_defaults
    params[:page] ||= 1
    params[:per_page] ||= 10
  end
end
