class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.integer :value
      t.boolean :correct
      t.integer :started_at
      t.integer :completed_at
      t.references :problem, null: false, foreign_key: true

      t.timestamps
    end
  end
end
