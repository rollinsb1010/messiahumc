class StaffController < ApplicationController
  protect_from_forgery

  protected

  def find_all_staff_members
    @all_categories = ::Refinery::StaffMembers::StaffCategory.all
    @right_categories = []
    @left_categories = [
      {
        name: 'Pastors',
        members: ::Refinery::Pastors::Pastor.all,
        url: lambda { |p| refinery.pastors_pastor_path(p) },
      }
    ]
    ::Refinery::StaffMembers::StaffCategory.where(index_placement: 'left').each { |c| @left_categories << get_staff_category(c) }
    ::Refinery::StaffMembers::StaffCategory.where(index_placement: 'right').each { |c| @right_categories << get_staff_category(c) }
  end

  def get_staff_category(category)
    {
      name: category.name,
      members: category.staff_members,
      url: lambda { |s| refinery.by_category_staff_members_staff_members_path(category) },
    }
  end
end
