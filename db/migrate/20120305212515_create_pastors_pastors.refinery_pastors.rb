# This migration comes from refinery_pastors (originally 1)
class CreatePastorsPastors < ActiveRecord::Migration

  def up
    create_table :refinery_pastors do |t|
      t.string :name
      t.string :job_title
      t.integer :thumbnail_id
      t.integer :large_photo_id
      t.text :bio
      t.string :email
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-pastors"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/pastors/pastors"})
    end

    drop_table :refinery_pastors

  end

end
