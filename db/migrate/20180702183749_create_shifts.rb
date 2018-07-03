class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, foreign_key: true
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
