class CreatePlayerProblemAggregates < ActiveRecord::Migration[7.1]
  def change
    create_table :player_problem_aggregates do |t|
      t.references :player, null: false, foreign_key: true
      t.references :problem, null: false, foreign_key: true
      t.integer :attempts, null: false, default: 0
      t.integer :correct, null: false, default: 0
      t.integer :min_time, null: false, default: 0
      t.integer :max_time, null: false, default: 0
      t.integer :average_time, null: false, default: 0

      t.timestamps
    end

    add_index :player_problem_aggregates, [:player_id, :problem_id], unique: true
  end
end
