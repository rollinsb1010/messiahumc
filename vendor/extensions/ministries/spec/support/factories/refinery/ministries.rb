FactoryGirl.define do
  factory :ministry, class: Refinery::Ministries::Ministry do
    sequence(:name) { |n| "Ministry #{n}" }
    ministry_category
  end
end

