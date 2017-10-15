class CreateFights < ActiveRecord::Migration[5.1]
  def change
    create_table :fights do |t|
      t.integer :fighter_1
      t.integer :fighter_2
      t.string :winner
      t.string :fight_description

      t.timestamps
    end
  end
end
