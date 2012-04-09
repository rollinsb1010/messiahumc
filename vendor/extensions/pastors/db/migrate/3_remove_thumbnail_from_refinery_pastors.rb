class RemoveThumbnailFromRefineryPastors < ActiveRecord::Migration
  def up
    remove_column :refinery_pastors, :thumbnail_id
  end

  def down
    add_column :refinery_pastors, :thumbnail_id, :integer
  end
end

