SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :about, 'About Messiah', refinery.root_path, highlights_on: /\/$/

    primary.item :meet_us, 'Meet Us', refinery.staff_members_staff_members_path, highlights_on: /\/meet_us|\/pastors|\/staff_members/ do |meet_us|
      meet_us.item :pastors, 'Pastors', refinery.pastors_pastors_path, highlights_on: /\/pastors/
      ::Refinery::StaffMembers::StaffCategory.all.each do |category|
        meet_us.item category.name.parameterize.underscore, category.name, refinery.by_category_staff_members_staff_members_path(category)
      end
    end

    primary.item :events, 'Events', refinery.events_events_path, highlights_on: /\/events$/
    primary.item :worship, 'Worship', Rails.application.routes.url_helpers.worship_path, highlights_on: /\/worship/

    primary.item :ministry, 'Ministry', refinery.ministries_ministries_path, highlights_on: /\/ministries/ do |ministry|
      ::Refinery::Ministries::MinistryCategory.all.each do |category|
        ministry.item category.name.parameterize.underscore, category.name, refinery.by_category_ministries_ministries_path(category)
      end
    end

    primary.item :events, 'Missions', refinery.missions_missions_path, highlights_on: /\/missions$/ do |missions|
      ::Refinery::Missions::MissionCategory.all.each do |category|
        missions.item category.name.parameterize.underscore, category.name, refinery.by_category_missions_missions_path(category)
      end
    end

    primary.item :youth, 'Youth', '/youth_ministries'
    primary.item :supporting, 'Supporting Messiah', '/supporting_messiah'
  end
end
