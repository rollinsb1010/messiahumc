FactoryGirl.define do
  factory :staff_member, class: Refinery::StaffMembers::StaffMember do
    sequence(:name) { |n| "Staff Member #{n}" }
    sequence(:email) { |n| "staff_member#{n}@email.com" }
    category
  end
end

