class WorshippingController < ApplicationController
  protect_from_forgery
  before_filter :set_left_sidebar

  private
  def set_left_sidebar
    left_sidebar = show_left_sidebar 'Worship'

    left_sidebar.add_item 'Sermons', refinery.sermons_sermons_path, %r(/sermons)
    left_sidebar.add_item 'Messengers', refinery.messengers_messengers_path
    left_sidebar.add_item 'Worship Schedule', '/worship-page/worship-schedule'
    left_sidebar.add_item 'Weddings', '/worship-page/weddings'
    left_sidebar.add_item 'Funerals', '/worship-page/funerals'
    left_sidebar.add_item 'Baptisms', '/worship-page/baptisms'
    left_sidebar.add_item 'Sunday School', '/worship-page/sunday-school'
  end
end
