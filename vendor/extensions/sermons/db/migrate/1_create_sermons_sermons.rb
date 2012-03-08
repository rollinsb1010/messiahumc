class CreateSermonsSermons < ActiveRecord::Migration

  def up
    create_table :refinery_sermons do |t|
      t.datetime :date
      t.string :speaker
      t.boolean :service
      t.string :title
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
