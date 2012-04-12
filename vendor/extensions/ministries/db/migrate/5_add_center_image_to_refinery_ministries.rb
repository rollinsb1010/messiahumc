class AddCenterImageToRefineryMinistries < ActiveRecord::Migration
  def change
    add_column :refinery_ministries, :center_image_id, :integer
  end
end
