ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../') unless defined?(ENGINE_RAILS_ROOT)

def setup_environment
  # Configure Rails Environment
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'prickle/capybara'
  require 'refinerycms-testing'

#  Rails.backtrace_cleaner.remove_silencers!

  RSpec.configure do |config|
    config.mock_with :rr
    config.treat_symbols_as_metadata_keys_with_true_values = true
#    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
  end

  #ActiveRecord::Base.logger = Logger.new($stdout)
end

def each_run
  Rails.cache.clear
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload

  Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories including factories.
  ([ENGINE_RAILS_ROOT, Rails.root.to_s].uniq | ::Refinery::Plugins.registered.pathnames).map{|p|
    Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
  }.flatten.sort.each do |support_file|
    require support_file
  end
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?
  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end
else
  setup_environment
  each_run
end
