class AddEventRefToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :event, foreign_key: true
  end
end
