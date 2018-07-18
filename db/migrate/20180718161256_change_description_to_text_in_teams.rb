class ChangeDescriptionToTextInTeams < ActiveRecord::Migration[5.2]
  def up
    change_column :teams, :description, :text
  end

  def down
    change_column :teams, :description, :string
  end
end
