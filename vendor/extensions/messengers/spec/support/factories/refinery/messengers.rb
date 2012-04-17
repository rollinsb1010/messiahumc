FactoryGirl.define do
  factory :messenger, class: Refinery::Messengers::Messenger do
    messenger_type 'weekly'
    published_at Time.now
  end
end
