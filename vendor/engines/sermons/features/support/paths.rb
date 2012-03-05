module NavigationHelpers
  module Refinery
    module Sermons
      def path_to(page_name)
        case page_name
        when /the list of sermons/
          admin_sermons_path

         when /the new sermon form/
          new_admin_sermon_path
        else
          nil
        end
      end
    end
  end
end
