class AddFriendlyIdToSermonCategories < ActiveRecord::Migration
  def change
    change_table :refinery_sermon_categories do |t|
      t.string :slug
      t.index :slug
    end
  end
end
