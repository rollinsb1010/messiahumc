FactoryGirl.define do
  factory :pastor, class: Refinery::Pastors::Pastor do
    sequence(:name) { |n| "Pastor #{n}" }
    sequence(:email) { |n| "pastor#{n}@email.com" }
  end
end

