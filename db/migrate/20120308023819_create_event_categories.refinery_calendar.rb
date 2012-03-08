# This migration comes from refinery_calendar (originally 2)
class CreateEventCategories < ActiveRecord::Migration
  def change
    create_table :refinery_event_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
