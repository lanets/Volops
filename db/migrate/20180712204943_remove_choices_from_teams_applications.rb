class RemoveChoicesFromTeamsApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams_applications, :first_choice_id
    remove_column :teams_applications, :second_choice_id
    remove_column :teams_applications, :third_choice_id
    add_reference :teams_applications, :team, foreign_key: true
    add_column :teams_applications, :priority, :integer
  end
end
