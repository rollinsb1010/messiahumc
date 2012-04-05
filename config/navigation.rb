SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :about, 'About Messiah', refinery.staff_members_staff_members_path, highlights_on: /\/staff_members/
    primary.item :events, 'Events', refinery.calendar_events_path, highlights_on: /\/events/
    primary.item :worship, 'Worship', Rails.application.routes.url_helpers.worship_path, highlights_on: /\/worship/
    primary.item :ministry, 'Ministry', refinery.ministries_ministries_path, highlights_on: /\/ministries/
    primary.item :missions, 'Missions', '#'
    primary.item :youth, 'Youth', '#'
    primary.item :supportin, 'Supporting Messiah', '#'
  end
end
