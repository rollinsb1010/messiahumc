
FactoryGirl.define do
  factory :signup, :class => Refinery::Signups::Signup do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

