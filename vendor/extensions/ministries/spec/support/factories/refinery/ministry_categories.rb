FactoryGirl.define do
  factory :ministry_category, class: ::Refinery::Ministries::MinistryCategory do
    sequence(:name) { |n| "Ministry Category #{n}"}
    index_placement 'left'
  end
end
