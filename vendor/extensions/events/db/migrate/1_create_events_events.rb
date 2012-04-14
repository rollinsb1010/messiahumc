class CreateEventsEvents < ActiveRecord::Migration

  def up
    create_table :refinery_events do |t|
      t.string :title
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :repetition
      t.string :location
      t.string :short_description
      t.text :long_description
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :notes
      t.integer :image_id
      t.integer :ministry_id
      t.boolean :highlighted
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-events"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/events/events"})
    end

    drop_table :refinery_events

  end

end
