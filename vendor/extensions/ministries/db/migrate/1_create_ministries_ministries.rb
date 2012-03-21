class CreateMinistriesMinistries < ActiveRecord::Migration

  def up
    create_table :refinery_ministries do |t|
      t.string :name
      t.integer :ministry_category_id
      t.text :description
      t.integer :logo_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-ministries"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/ministries/ministries"})
    end

    drop_table :refinery_ministries

  end

end
