include ActionView::Helpers::TextHelper

if Refinery::StaffMembers::StaffCategory.all.empty?
  categories = ['Building Staff', 'Youth and Children', 'Music Staff', 'Our Day Preschool', 'Lay Leaders']

  categories.each_with_index do |c, index|
    ::Refinery::StaffMembers::StaffCategory.create(name: c, index_placement: cycle('left', 'right'), position: index)
  end
end
