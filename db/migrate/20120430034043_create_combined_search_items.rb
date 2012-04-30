class CreateCombinedSearchItems < ActiveRecord::Migration
  def change
    create_table :combined_search_items do |t|
      t.string :title
      t.text :description
      t.string :url
      t.text :index_data
      t.integer :source_id
      t.string :source_type

      t.timestamps
    end
  end
end
