module Refinery
  module Messengers
    module Admin
      class MessengersController < ::Refinery::AdminController

        crudify :'refinery/messengers/messenger', title_attribute: 'messenger_type', xhr_paging: true, sortable: false

      end
    end
  end
end
