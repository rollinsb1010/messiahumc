class AddHighlightedFieldToRefineryMinistries < ActiveRecord::Migration
  def change
    add_column :refinery_ministries, :highlighted, :boolean
  end
end
