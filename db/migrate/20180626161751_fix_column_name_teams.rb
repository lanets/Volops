class FixColumnNameTeams < ActiveRecord::Migration[5.2]
  def change
    rename_column :teams, :event_id, :events_id
  end
end
