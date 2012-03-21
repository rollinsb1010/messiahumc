# This migration comes from refinery_ministries (originally 2)
class CreateMinistryCategories < ActiveRecord::Migration

  def up
    create_table :refinery_ministry_categories do |t|
      t.string :name
      t.string :index_placement
      t.integer :position

      t.timestamps
    end

  end

  def down
    drop_table :refinery_ministry_categories
  end

end
