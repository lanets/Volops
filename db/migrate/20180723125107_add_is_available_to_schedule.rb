class AddIsAvailableToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :available, :boolean
    add_column :schedules, :assigned, :boolean
    add_column :schedules, :position, :integer
  end
end
