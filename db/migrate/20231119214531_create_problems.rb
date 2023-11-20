class CreateProblems < ActiveRecord::Migration[7.1]
  def change
    create_table :problems do |t|
      t.string :operation
      t.integer :x
      t.integer :y
      t.integer :solution

      t.timestamps
    end

    add_index :problems, [:x, :y, :operation], unique: true
  end
end
