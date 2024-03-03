class CreateOneTimePasswordRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :one_time_password_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
