class CreateTeamApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :team_applications do |t|
      t.references :first_choice, foreign_key: { to_table: :teams }
      t.references :second_choice, foreign_key: { to_table: :teams }
      t.references :third_choice, foreign_key: { to_table: :teams }
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
