# This migration comes from refinery_staff_members (originally 3)
class AddFriendlyIdToStaffMembersAndStaffCategories < ActiveRecord::Migration
  def change
    change_table :refinery_staff_members do |t|
      t.string :slug
      t.index :slug
    end

    change_table :refinery_staff_categories do |t|
      t.string :slug
      t.index :slug
    end
  end
end
