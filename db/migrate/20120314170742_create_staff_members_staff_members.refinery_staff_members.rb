# This migration comes from refinery_staff_members (originally 1)
class CreateStaffMembersStaffMembers < ActiveRecord::Migration

  def up
    create_table :refinery_staff_members do |t|
      t.string :name
      t.integer :category_id
      t.string :job_title
      t.integer :photo_id
      t.text :bio
      t.string :email
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-staff_members"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/staff_members/staff_members"})
    end

    drop_table :refinery_staff_members

  end

end
