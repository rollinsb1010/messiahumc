
FactoryGirl.define do
  factory :sermon, :class => Refinery::Sermons::Sermon do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

