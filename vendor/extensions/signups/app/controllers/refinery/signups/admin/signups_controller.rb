module Refinery
  module Signups
    module Admin
      class SignupsController < ::Refinery::AdminController

        crudify :'refinery/signups/signup',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
