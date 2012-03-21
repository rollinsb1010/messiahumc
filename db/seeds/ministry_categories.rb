include ActionView::Helpers::TextHelper

if Refinery::Ministries::MinistryCategory.all.empty?
  categories = ['Fellowship', 'Church & Society', 'Missions', 'Seasonal']

  categories.each_with_index do |c, index|
    ::Refinery::Ministries::MinistryCategory.create(name: c, index_placement: cycle('left', 'right'), position: index)
  end
end
