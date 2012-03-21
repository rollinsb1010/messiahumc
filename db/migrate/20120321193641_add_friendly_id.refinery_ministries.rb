# This migration comes from refinery_ministries (originally 3)
class AddFriendlyId < ActiveRecord::Migration
  def change
    change_table :refinery_ministries do |t|
      t.string :slug
      t.index :slug
    end

    change_table :refinery_ministry_categories do |t|
      t.string :slug
      t.index :slug
    end
  end
end
