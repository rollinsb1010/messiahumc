class SearchableModel < Refinery::Core::BaseModel
  self.abstract_class = true

  self.after_save :save_to_combined_search
  self.before_destroy :destroy_from_combined_search

  def save_to_combined_search
    item = CombinedSearchItem.find_or_create_by_source_id_and_source_type(self.id, self.class.name)
    item.title = self.title
    item.url = self.url
    item.description = self.summary
    item.index_data = @@fields[self.class.name].inject('') { |data, field| "#{data}\n#{self.send(field)}" }

    item.save
  end

  def destroy_from_combined_search
    item = CombinedSearchItem.find_by_source_id_and_source_type(self.id, self.class.name)
    item.delete unless item.nil?
  end

  class << self
    def acts_as_indexed(options)
      @@fields ||= {}
      @@fields[self.name] = options[:fields]
    end
  end
end
