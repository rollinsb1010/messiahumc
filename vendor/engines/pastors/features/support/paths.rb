module NavigationHelpers
  module Refinery
    module Pastors
      def path_to(page_name)
        case page_name
        when /the list of pastors/
          admin_pastors_path

         when /the new pastor form/
          new_admin_pastor_path
        else
          nil
        end
      end
    end
  end
end
