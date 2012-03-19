
FactoryGirl.define do
  factory :messenger, :class => Refinery::Messengers::Messenger do
    sequence(:messenger_type) { |n| "refinery#{n}" }
  end
end

