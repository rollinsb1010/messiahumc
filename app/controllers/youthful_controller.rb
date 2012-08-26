class YouthfulController < ApplicationController
  protect_from_forgery
  before_filter :set_left_sidebar

  private
  def set_left_sidebar
    left_sidebar = show_left_sidebar 'Youth'

    left_sidebar.add_item 'Children', '/youth/children'
    left_sidebar.add_item 'Middle School', '/youth/middle-school'
    left_sidebar.add_item 'High School', '/youth/high-school'
    left_sidebar.add_item 'Boy Scouts', '/youth/boy-scouts'
    left_sidebar.add_item 'Sunday School', '/worship-page/sunday-school'
  end
end
