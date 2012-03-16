module Refinery
  module Sermons
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sermons

      engine_name :refinery_sermons

      initializer "register refinerycms_sermons plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sermons"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sermons_admin_sermons_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sermons/sermon'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Sermons)
      end
    end
  end
end
