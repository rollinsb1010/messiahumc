# This migration comes from refinery_sermons (originally 2)
class AddFriendlyIdToSermons < ActiveRecord::Migration
  def up
    change_table :refinery_sermons do |t|
      t.string :slug
      t.index :slug
    end
  end

  def down
    change_table :refinery_sermons do |t|
      t.remove_index :slug
      t.remove :slug
    end
  end
end
