
FactoryGirl.define do
  factory :mission, :class => Refinery::Missions::Mission do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

