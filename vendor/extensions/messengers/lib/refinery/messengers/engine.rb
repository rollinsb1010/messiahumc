module Refinery
  module Messengers
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Messengers

      engine_name :refinery_messengers

      initializer "register refinerycms_messengers plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "messengers"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.messengers_admin_messengers_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/messengers/messenger',
            :title => 'messenger_type'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Messengers)
      end
    end
  end
end
