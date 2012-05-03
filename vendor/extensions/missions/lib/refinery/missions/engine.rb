module Refinery
  module Missions
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Missions

      engine_name :refinery_missions

      initializer "register refinerycms_missions plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "missions"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.missions_admin_missions_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/missions/mission',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Missions)
      end
    end
  end
end
