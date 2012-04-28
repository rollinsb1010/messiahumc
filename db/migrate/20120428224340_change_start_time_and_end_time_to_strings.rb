class ChangeStartTimeAndEndTimeToStrings < ActiveRecord::Migration
  def up
    change_column :refinery_events, :start_time, :string
    change_column :refinery_events, :end_time, :string
  end

  def down
    change_column :refinery_events, :start_time, :time
    change_column :refinery_events, :end_time, :time
  end
end
