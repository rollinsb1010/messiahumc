class AddFriendlyIdToSermons < ActiveRecord::Migration
  def change
    change_table :refinery_sermons do |t|
      t.string :slug
      t.index :slug
    end
  end
end
