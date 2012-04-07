class ChangePastorsPhotoFieldName < ActiveRecord::Migration
  def up
    rename_column :refinery_pastors, :large_photo_id, :photo_id
  end

  def down
    rename_column :refinery_pastors, :photo_id, :large_photo_id
  end
end
