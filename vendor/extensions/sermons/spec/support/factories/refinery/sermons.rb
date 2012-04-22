FactoryGirl.define do
  factory :sermon, class: Refinery::Sermons::Sermon do
    sequence(:title) { |n| "Sermon #{n}" }
    date Time.now
    location 'sanctuary'
    pastor
  end
end

