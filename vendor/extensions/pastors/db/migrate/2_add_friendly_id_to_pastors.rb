class AddFriendlyIdToPastors < ActiveRecord::Migration
  def change
    change_table :refinery_pastors do |t|
      t.string :slug
      t.index :slug
    end
  end
end
