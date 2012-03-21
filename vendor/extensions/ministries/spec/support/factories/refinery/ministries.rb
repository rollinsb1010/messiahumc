
FactoryGirl.define do
  factory :ministry, :class => Refinery::Ministries::Ministry do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

