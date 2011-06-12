class CreatePastors < ActiveRecord::Migration

  def self.up
    create_table :pastors do |t|
      t.string :name
      t.integer :photo_id
      t.text :what_i_do
      t.text :my_god_story
      t.text :education
      t.text :family
      t.text :hobbies
      t.integer :position

      t.timestamps
    end

    add_index :pastors, :id

    load(Rails.root.join('db', 'seeds', 'pastors.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "pastors"})

    Page.delete_all({:link_url => "/pastors"})

    drop_table :pastors
  end

end
