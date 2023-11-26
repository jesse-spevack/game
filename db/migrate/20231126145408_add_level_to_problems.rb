class AddLevelToProblems < ActiveRecord::Migration[7.1]
  def change
    add_column :problems, :level, :integer
    add_index :problems, :level
  end
end
