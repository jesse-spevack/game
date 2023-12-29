class AddColumnsToPlayerProblemAggregates < ActiveRecord::Migration[7.1]
  def change
    add_column :player_problem_aggregates, :priority, :integer, default: 0
    add_column :player_problem_aggregates, :proficient, :boolean, default: false
    add_column :player_problem_aggregates, :fast, :boolean, default: false
    add_column :player_problem_aggregates, :fast_enough, :boolean, default: false
    add_column :player_problem_aggregates, :retired, :boolean, default: false
  end
end
