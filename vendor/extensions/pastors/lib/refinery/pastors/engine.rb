module Refinery
  module Pastors
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Pastors

      engine_name :refinery_pastors

      initializer "register refinerycms_pastors plugin" do |app|
        Refinery::Plugin.register do |plugin|
          plugin.name = "pastors"
          plugin.url = {
            :controller => 'refinery/pastors/admin/pastors',
            :action => 'index'
          }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/pastors/pastor',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Pastors)
      end
    end
  end
end
