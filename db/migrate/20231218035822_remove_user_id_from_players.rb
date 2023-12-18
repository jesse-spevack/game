class RemoveUserIdFromPlayers < ActiveRecord::Migration[7.1]
  def change
    remove_column :players, :user_id, :bigint
  end
end
