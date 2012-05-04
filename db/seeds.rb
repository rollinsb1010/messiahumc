# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by RefineryCMS Copywriting engine
Refinery::Copywriting::Engine.load_seed

Refinery::Pastors::Engine.load_seed

Refinery::Sermons::Engine.load_seed

Dir[File.join(File.dirname(__FILE__), 'seeds', '*')].each do |file|
  require file
end

Refinery::StaffMembers::Engine.load_seed

Refinery::Messengers::Engine.load_seed

Refinery::Ministries::Engine.load_seed

# Added by Refinery CMS Events extension
Refinery::Events::Engine.load_seed

# Added by Refinery CMS Missions extension
Refinery::Missions::Engine.load_seed
