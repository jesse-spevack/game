class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :controller
      t.string :action
      t.jsonb :query_parameters
      t.jsonb :request_parameters
      t.string :method
      t.string :uuid
      t.string :referer

      t.timestamps
    end
  end
end
