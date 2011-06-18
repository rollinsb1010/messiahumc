class CreatePastors < ActiveRecord::Migration

  def self.up
    create_table :pastors do |t|
      t.string :name
      t.string :job_title
      t.integer :thumbnail_id
      t.integer :large_photo_id
      t.text :bio
      t.string :email
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
