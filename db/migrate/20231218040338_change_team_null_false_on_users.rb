class ChangeTeamNullFalseOnUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :team_id, false
  end
end
