class ApplicationController < ActionController::Base
  before_filter :set_pagination_defaults, :inline_file_downloads
  protect_from_forgery
  layout 'general'

  def set_pagination_defaults
    params[:page] ||= 1
    params[:per_page] ||= 10
  end

  def inline_file_downloads
    # Force Dragonfly to view files attached to resources inline in the browser
    ::Dragonfly[:refinery_resources].configure do |c|
      c.content_disposition = :inline
    end
  end
end
