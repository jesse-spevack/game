class AddTeamIdToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :team, null: true, foreign_key: true
  end
end
