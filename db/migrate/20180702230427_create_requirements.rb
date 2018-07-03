class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.references :shift, foreign_key: true
      t.integer :mandatory
      t.integer :optional

      t.timestamps
    end
  end
end
