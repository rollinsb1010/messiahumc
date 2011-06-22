module Admin
  class SermonsController < Admin::BaseController

    crudify :sermon,
            :title_attribute => 'speaker', :xhr_paging => true

  end
end
