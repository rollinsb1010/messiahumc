module Refinery
  module Signups
    module Admin
      class SignupsController < ::Refinery::AdminController

        crudify :'refinery/signups/signup',
                :title_attribute => 'name', :xhr_paging => true

        def new
          @signup = Signup.new
          3.times { @signup.signup_slots.build }
        end
      end
    end
  end
end
