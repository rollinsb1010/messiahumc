# This migration comes from refinery_messengers (originally 1)
class CreateMessengersMessengers < ActiveRecord::Migration

  def up
    create_table :refinery_messengers do |t|
      t.string :messenger_type
      t.datetime :published_at
      t.integer :pdf_file_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-messengers"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/messengers/messengers"})
    end

    drop_table :refinery_messengers

  end

end
