class RemoveOldEventsEngine < ActiveRecord::Migration
  def up
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-calendar"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/events/events"})
    end

    drop_table :refinery_events
  end

  def down
    create_table :refinery_events do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.string :venue_name
      t.string :venue_address
      t.decimal :ticket_price, :precision => 8, :scale => 2
      t.string :ticket_link
      t.text :description
      t.boolean :featured
      t.integer :image_id
      t.integer :position

      t.timestamps
    end
  end
end
