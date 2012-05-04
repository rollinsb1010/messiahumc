class CreateMissionCategories < ActiveRecord::Migration

  def up
    create_table :refinery_mission_categories do |t|
      t.string :name
      t.string :index_placement
      t.integer :position

      t.timestamps
    end

  end

  def down
    drop_table :refinery_mission_categories
  end

end

