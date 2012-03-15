class CreateNewSermonsTable < ActiveRecord::Migration

  def up
    create_table :refinery_sermons do |t|
      t.integer :pastor_id
      t.date :date
      t.string :title
      t.string :location
      t.text :description
      t.text :scripture_reading
      t.integer :mp3_file_id
      t.integer :image_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sermons"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sermons/sermons"})
    end

    drop_table :refinery_sermons

  end

end
