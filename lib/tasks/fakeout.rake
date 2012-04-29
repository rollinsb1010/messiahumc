class Fakeout

  MODELS = %w(
    ::Refinery::Pastors::Pastor
    ::Refinery::Sermons::Sermon
    ::Refinery::Events::Event
  )

  def build__refinery_pastors_pastor
    {
      name: Faker::Name.name,
      job_title: 1.sentence,
      email: Faker::Internet.email,
      bio: 3.paragraphs,
  }
  end

  def build__refinery_sermons_sermon
    {
      pastor: ::Refinery::Pastors::Pastor.random,
      date: fake_time_from(1.year.ago),
      title: 1.sentence,
      location: %w(sanctuary celebration).sample,
      description: 3.sentences,
      scripture_reading: 1.sentence,
  }
  end

  def build__refinery_events_event
    {
      title: 1.sentence,
      date: fake_time_from(1.year.ago),
      start_time: fake_time_from(([1.year.ago, 1.week.ago, 1.month.ago]).sample).to_time,
      end_time: fake_time_from(([1.year.ago, 1.week.ago, 1.month.ago]).sample).to_time,
      repeats: %w(never weekly monthly).sample,
      location: 1.sentence,
      short_description: 1.sentence,
      long_description: 3.sentences,
      contact_name: Faker::Name.name,
      contact_email: Faker::Internet.email,
      contact_phone: Faker::PhoneNumber.phone_number,
      notes: 1.sentence,
      ministry: ::Refinery::Ministries::Ministry.random,
      highlighted: [true, false].sample,
  }
  end

  def post_fake
  end

  def tiny
    1
  end

  def small
    25+rand(50)
  end

  def medium
    250+rand(250)
  end

  def large
    1000+rand(500)
  end

  # END Customizing
  attr_accessor :size

  def initialize(size, prompt=true)
    self.size = size
  end

  def builder_for(model)
    "build_#{model.downcase}".parameterize.underscore
  end

  def fakeout
    puts "Faking it ... (#{size})"
    Fakeout.disable_mailers
    MODELS.each do |model|
      if !respond_to?(builder_for(model))
        puts "  * #{model.pluralize}: **warning** I couldn't find a #{builder_for(model)} method"
        next
      end
      1.upto(send(size)) do
        attributes = send(builder_for(model))
        model.constantize.create!(attributes) if attributes && !attributes.empty?
      end
      puts "  * #{model.pluralize}: #{model.constantize.count(:all)}"
    end
    post_fake
    puts "Done, I Faked it!"
  end

  def self.prompt
    puts "Really? This will clean all #{MODELS.map(&:pluralize).join(', ')} from your #{Rails.env} database y/n? "
    STDOUT.flush
    (STDIN.gets =~ /^y|^Y/) ? true : exit(0)
  end

  def self.clean(prompt = true)
    self.prompt if prompt
    puts "Cleaning all ..."
    Fakeout.disable_mailers
    MODELS.each do |model|
      model.constantize.delete_all
    end
  end

  # by default, all mailings are disabled on faking out
  def self.disable_mailers
    ActionMailer::Base.perform_deliveries = false
  end


  private

  # useful for prepending to a string for getting a more unique string
  def random_letters(length = 2)
    Array.new(length) { (rand(122-97) + 97).chr }.join
  end

  # fake a time from: time ago + 1-8770 (a year) hours after
  def fake_time_from(time_ago = 1.year.ago)
    time_ago+(rand(8770)).hours
  end
end


# the tasks, hook to class above - use like so;
# rake fakeout:clean
# rake fakeout:small[noprompt] - no confirm prompt asked, useful for heroku or non-interactive use
# rake fakeout:medium RAILS_ENV=bananas
#.. etc.
namespace :fakeout do

  desc "clean away all data"
  task :clean, [:no_prompt] => :environment do |t, args|
    Fakeout.clean(args.no_prompt.nil?)
  end

  desc "fake out a tiny dataset"
  task :tiny, [:no_prompt] => :clean do |t, args|
    Fakeout.new(:tiny).fakeout
  end

  desc "fake out a small dataset"
  task :small, [:no_prompt] => :clean do |t, args|
    Fakeout.new(:small).fakeout
  end

  desc "fake out a medium dataset"
  task :medium, [:no_prompt] => :clean do |t, args|
    Fakeout.new(:medium).fakeout
  end

  desc "fake out a large dataset"
  task :large, [:no_prompt] => :clean do |t, args|
    Fakeout.new(:large).fakeout
  end
end
