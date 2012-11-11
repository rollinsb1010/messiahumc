# This migration comes from refinery_signups (originally 1)
class CreateSignupsSignups < ActiveRecord::Migration

  def up
    create_table :refinery_signups do |t|
      t.string :name
      t.text :description
      t.string :responsible_name
      t.string :responsible_email
      t.string :responsible_phone
      t.string :dates
      t.string :times
      t.integer :position

      t.timestamps
    end

    create_table :refinery_signup_slots do |t|
      t.string :description
      t.integer :available_slots
      t.integer :signup_id

      t.timestamps
    end

    create_table :refinery_attendees do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :signup_slot_id

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-signups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/signups/signups"})
    end

    drop_table :refinery_signups
    drop_table :refinery_signup_slots
    drop_table :refiner_attendees

  end

end
