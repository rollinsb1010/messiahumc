
FactoryGirl.define do
  factory :pastor, :class => Refinery::Pastors::Pastor do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

