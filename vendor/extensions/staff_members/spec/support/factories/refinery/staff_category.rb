FactoryGirl.define do
  factory :category, class: ::Refinery::StaffMembers::StaffCategory do
    sequence(:name) { |n| "Staff Category #{n}" }
    index_placement 'left'
  end
end
