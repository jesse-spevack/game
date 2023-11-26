class ChangeLevelNullFalse < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:problems, :level, false)
    change_column_null(:players, :level, false)
  end
end
