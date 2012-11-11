module Refinery
  module Signups
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Signups

      engine_name :refinery_signups

      initializer "register refinerycms_signups plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "signups"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.signups_admin_signups_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/signups/signup',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Signups)
      end
    end
  end
end
