SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :about, 'About Messiah', refinery.root_path, highlights_on: /\/$/
    primary.item :worship, 'Worship', Rails.application.routes.url_helpers.worship_path, highlights_on: /\/worship/
    primary.item :meet_us, 'Meet Us', refinery.staff_members_staff_members_path, highlights_on: /\/meet_us|\/pastors|\/staff_members/
    primary.item :ministry, 'Ministry', refinery.ministries_ministries_path, highlights_on: /\/ministries/
    primary.item :missions, 'Missions', '#'
    primary.item :youth, 'Youth', '#'
    primary.item :supporting, 'Supporting Messiah', '#'
  end
end
