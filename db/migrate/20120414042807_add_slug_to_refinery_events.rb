class AddSlugToRefineryEvents < ActiveRecord::Migration
  def change
    add_column :refinery_events, :slug, :string
    add_index :refinery_events, :slug, unique: true
  end
end
