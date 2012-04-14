module LeftSidebarHelper
  class MenuItem
    attr_accessor :title, :url, :items

    def initialize(request, title = '', url = '', matcher = nil)
      @request = request
      @title = title
      @url = url
      @matcher = matcher || %r(/#{title.parameterize}$)
      @items = []
    end

    def add_item(title, url, matcher = nil)
      @items << MenuItem.new(@request, title, url, matcher)
      @items.last
    end

    def self_matches?
      @request.fullpath =~ @matcher
    end

    def self_or_children_matches?
      self_matches? or @items.any?(&:self_or_children_matches?)
    end
  end

  class LeftSidebar < MenuItem
  end

  def get_left_sidebar
    @left_sidebar
  end

  def render_left_sidebar
    render 'shared/left_sidebar'
  end

  module ControllerMethods
    def show_left_sidebar(title)
      @left_sidebar ||= LeftSidebar.new request
      @left_sidebar.title = title
      @left_sidebar
    end
  end
end

ActionView.send(:include, LeftSidebarHelper)
ApplicationController.send(:include, LeftSidebarHelper::ControllerMethods)
