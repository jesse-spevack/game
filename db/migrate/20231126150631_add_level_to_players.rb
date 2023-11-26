class AddLevelToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :level, :integer
    add_index :players, :level
  end
end
