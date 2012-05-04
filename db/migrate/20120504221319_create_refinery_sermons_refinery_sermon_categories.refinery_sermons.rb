# This migration comes from refinery_sermons (originally 4)
class CreateRefinerySermonsRefinerySermonCategories < ActiveRecord::Migration
  def up
    create_table :refinery_sermons_sermon_categories do |t|
      t.integer :sermon_id
      t.integer :category_id
    end

    change_table :refinery_sermons_sermon_categories do |t|
      t.index :sermon_id
      t.index :category_id
    end
  end

  def down
    drop_table :refinery_sermons_sermon_categories
  end
end
