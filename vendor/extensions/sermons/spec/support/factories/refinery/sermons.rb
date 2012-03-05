
FactoryGirl.define do
  factory :sermon, :class => Refinery::Sermons::Sermon do
    sequence(:speaker) { |n| "refinery#{n}" }
  end
end

