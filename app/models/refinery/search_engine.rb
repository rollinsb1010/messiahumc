module Refinery
  class SearchEngine

    def self.search(query)
      CombinedSearchItem.with_query(query)
    end

  end
end
