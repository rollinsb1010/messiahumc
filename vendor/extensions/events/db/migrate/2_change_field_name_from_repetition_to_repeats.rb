class ChangeFieldNameFromRepetitionToRepeats < ActiveRecord::Migration
  def change
    rename_column :refinery_events, :repetition, :repeats
  end
end
