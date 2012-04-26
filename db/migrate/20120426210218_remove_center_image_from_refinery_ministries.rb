class RemoveCenterImageFromRefineryMinistries < ActiveRecord::Migration
  def up
    remove_column :refinery_ministries, :center_image_id
  end

  def down
    add_column :refinery_ministries, :center_image_id, :integer
  end
end
