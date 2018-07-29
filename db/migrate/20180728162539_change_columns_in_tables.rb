class ChangeColumnsInTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :teams_id
    remove_column :events, :user_id
    remove_column :schedules, :available
    remove_column :schedules, :assigned
    remove_column :shifts, :users_id
    remove_column :teams, :user_id
    change_column_default :users, :role, 'user'
  end
end
