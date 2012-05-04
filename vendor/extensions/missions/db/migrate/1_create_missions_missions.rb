class CreateMissionsMissions < ActiveRecord::Migration

  def up
    create_table :refinery_missions do |t|
      t.string :name
      t.integer :category_id
      t.text :description
      t.integer :logo_id
      t.boolean :highlighted
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-missions"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/missions/missions"})
    end

    drop_table :refinery_missions

  end

end
