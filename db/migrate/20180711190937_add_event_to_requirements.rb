class AddEventToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_reference :requirements, :event, foreign_key: true
  end
end
