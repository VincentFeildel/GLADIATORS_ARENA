class CreateFighters < ActiveRecord::Migration[5.1]
  def change
    create_table :fighters do |t|
      t.string :name
      t.integer :life
      t.integer :attack
      t.integer :endurance
      t.integer :precision
      t.integer :dodge
      t.integer :armor
      t.integer :resistance
      t.string :type

      t.timestamps
    end
  end
end
