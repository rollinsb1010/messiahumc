class CombinedSearchItem < ActiveRecord::Base
  attr_accessible :description, :index_data, :link, :source_id, :source_type, :title
  acts_as_indexed fields: [:index_data]
end
