class ChangeTeamNullFalseOnPlayers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :players, :team_id, false
  end
end
