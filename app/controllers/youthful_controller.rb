class YouthfulController < ApplicationController
  protect_from_forgery
  before_filter :set_left_sidebar

  private
  def set_left_sidebar
    left_sidebar = show_left_sidebar 'Youth'

    left_sidebar.add_item 'Children', '/youth-page/children'
    left_sidebar.add_item 'Middle School', '/youth-page/middle-school'
    left_sidebar.add_item 'High School', '/youth-page/high-school'
    left_sidebar.add_item 'Boy Scouts', '/youth-page/boy-scouts'
    left_sidebar.add_item 'Sunday School', '/worship-page/sunday-school'
    left_sidebar.add_item 'Safe Sactuaries', '/youth-page/safe-sanctuaries'
    left_sidebar.add_item 'Ourday', '/youth-page/ourday'
    left_sidebar.add_item 'Music', '/ministries/youth-music'
  end
end
