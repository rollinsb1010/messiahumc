module Refinery
  module Ministries
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Ministries

      engine_name :refinery_ministries

      initializer "register refinerycms_ministries plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "ministries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.ministries_admin_ministries_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/ministries/ministry',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Ministries)
      end
    end
  end
end
