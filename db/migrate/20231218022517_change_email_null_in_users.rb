class ChangeEmailNullInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :email, false
  end
end
