module Refinery
  module StaffMembers
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::StaffMembers

      engine_name :refinery_staff_members

      initializer "register refinerycms_staff_members plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "staff_members"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.staff_members_admin_staff_members_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/staff_members/staff_member',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::StaffMembers)
      end
    end
  end
end
