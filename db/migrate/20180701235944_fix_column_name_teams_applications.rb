class FixColumnNameTeamsApplications < ActiveRecord::Migration[5.2]
  def change
    rename_table :team_applications, :teams_applications
  end
end
