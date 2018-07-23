class AddNeedToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :mandatory, :boolean
  end
end
