class SearchableModel < Refinery::Core::BaseModel
  self.abstract_class = true

  self.after_create :save_to_combined_search

  def save_to_combined_search
    item = CombinedSearchItem.find_or_create_by_source_id(self.id)
    item.title = self.title
    item.url = self.url
    item.description = self.summary
    item.source_type = self.class.name
    item.index_data = @@fields.inject('') { |data, field| "#{data}\n#{self.send(field)}" }

    item.save
  end

  class << self
    def acts_as_indexed(options)
      @@fields = options[:fields]
    end
  end
end
