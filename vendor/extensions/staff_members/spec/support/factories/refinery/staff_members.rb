
FactoryGirl.define do
  factory :staff_member, :class => Refinery::StaffMembers::StaffMember do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

