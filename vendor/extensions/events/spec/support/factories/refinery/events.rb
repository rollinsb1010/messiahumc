FactoryGirl.define do
  factory :event, class: Refinery::Events::Event do
    sequence(:title) { |n| "Event #{n}" }
    date Time.now.to_date
    repeats 'never'
    sequence(:short_description) { |n| "Short description for #{n}" }
    sequence(:long_description) { |n| "Long description for #{n}" }
    sequence(:contact_email) { |n| "event_contact#{n}@email.com" }
  end

  factory :weekly_event, parent: :event do
    repeats 'weekly'
  end

  factory :monthly_event, parent: :event do
    repeats 'monthly'
  end
end
