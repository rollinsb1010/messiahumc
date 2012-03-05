require 'refinerycms-base'

module Refinery
  module Sermons
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sermons"
          plugin.activity = {
            :class => Sermon,
            :title => 'speaker'
          }
        end
      end
    end
  end
end
