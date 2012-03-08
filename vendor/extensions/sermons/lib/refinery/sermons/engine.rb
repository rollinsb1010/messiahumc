module Refinery
  module Sermons
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Sermons

      engine_name :refinery_sermons

      initializer "register refinerycms_sermons plugin" do |app|
        Refinery::Plugin.register do |plugin|
          plugin.name = "sermons"
          plugin.url = {
            :controller => 'refinery/sermons/admin/sermons',
            :action => 'index'
          }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/sermons/sermon',
            :title => 'speaker'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Sermons)
      end
    end
  end
end
