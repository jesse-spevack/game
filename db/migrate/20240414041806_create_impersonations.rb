class CreateImpersonations < ActiveRecord::Migration[7.1]
  def change
    create_table :impersonations do |t|
      t.references :impersonator, null: false, foreign_key: {to_table: :users}
      t.references :impersonatee, null: false, foreign_key: {to_table: :users}
      t.datetime :completed_at

      t.timestamps
    end
  end
end
