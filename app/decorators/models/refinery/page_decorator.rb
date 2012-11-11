Refinery::Page.class_eval do
  self.after_save :save_to_combined_search
  self.before_destroy :destroy_from_combined_search
  has_many :page_parts, :foreign_key => :refinery_page_id

  def save_to_combined_search
    item = CombinedSearchItem.find_or_create_by_source_id_and_source_type(self.id, self.class.name)
    item.title = self.title
    item.url = self.search_target_url
    item.description = self.body
    item.index_data = @@fields[self.class.name].inject('') { |data, field| "#{data}\n#{self.send(field)}" }

    item.save
  end

  def destroy_from_combined_search
    item = CombinedSearchItem.find_by_source_id_and_source_type(self.id, self.class.name)
    item.delete unless item.nil?
  end

  def body
    page_parts.first.try(:body) || ''
  end

  def search_target_url
    "/#{url_marketable[:path].join('/')}"
  end

  class << self
    def acts_as_indexed(options)
      @@fields ||= {}
      @@fields[self.name] = options[:fields]
    end
  end

  acts_as_indexed fields: [:slug, :link_url, :body]
end
