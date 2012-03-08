# This migration comes from refinery_calendar (originally 4)
class AddSlugs < ActiveRecord::Migration
  def change
    add_column :refinery_event_categories, :slug, :string
    add_column :refinery_events, :slug, :string

    add_index :refinery_event_categories, :slug, unique: true
    add_index :refinery_events, :slug, unique: true
  end
end
