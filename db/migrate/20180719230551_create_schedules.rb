class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.references :shift, foreign_key: true
      t.references :team, foreign_key: true
      t.references :event, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
