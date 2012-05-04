class AddFriendlyIdToMissions < ActiveRecord::Migration
  def change
    change_table :refinery_missions do |t|
      t.string :slug
      t.index :slug
    end

    change_table :refinery_mission_categories do |t|
      t.string :slug
      t.index :slug
    end
  end
end
