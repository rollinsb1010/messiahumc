class CreateRefinerySermonCategories < ActiveRecord::Migration
  def up
    create_table :refinery_sermon_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :refinery_sermon_categories
  end
end

