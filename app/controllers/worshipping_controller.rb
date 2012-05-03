class WorshippingController < ApplicationController
  protect_from_forgery
  before_filter :set_left_sidebar

  private
  def set_left_sidebar
    left_sidebar = show_left_sidebar 'Worship'

    left_sidebar.add_item 'Sermons', refinery.sermons_sermons_path, %r(/sermons)
    left_sidebar.add_item 'Weekly Messenger', refinery.messengers_messengers_path
    left_sidebar.add_item 'Worship Services', '#'
    left_sidebar.add_item 'Special Services', '#'
    left_sidebar.add_item 'Sunday School', '#'
    left_sidebar.add_item 'Prayer Groups', '#'
  end
end
