module Admin
  class PastorsController < Admin::BaseController

    crudify :pastor,
            :title_attribute => 'name', :xhr_paging => true

  end
end
