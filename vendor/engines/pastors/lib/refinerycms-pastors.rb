require 'refinerycms-base'

module Refinery
  module Pastors
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "pastors"
          plugin.activity = {
            :class => Pastor,
            :title => 'name'
          }
        end
      end
    end
  end
end
