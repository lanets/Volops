class AddTeamToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_reference :requirements, :team, foreign_key: true
  end
end
