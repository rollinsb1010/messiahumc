class CreateSermons < ActiveRecord::Migration

  def self.up
    create_table :sermons do |t|
      t.date :date
      t.string :speaker
      t.boolean :service
      t.string :title
      t.integer :position

      t.timestamps
    end

    add_index :sermons, :id

    load(Rails.root.join('db', 'seeds', 'sermons.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "sermons"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/sermons"})
    end

    drop_table :sermons
  end

end
