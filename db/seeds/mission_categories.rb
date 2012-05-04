include ActionView::Helpers::TextHelper

if Refinery::Missions::MissionCategory.all.empty?
  categories = ['Local', 'National', 'Global']

  categories.each_with_index do |c, index|
    ::Refinery::Missions::MissionCategory.create(name: c, index_placement: cycle('left', 'right'), position: index)
  end
end
