class RenameMissionCategoryField < ActiveRecord::Migration
  def change
    rename_column :refinery_missions, :category_id, :mission_category_id
  end
end
