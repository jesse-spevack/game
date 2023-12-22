class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :customer_token, null: false
      t.integer :amount_total, null: false
      t.string :invoice_token, null: false
      t.string :hosted_invoice_url, null: false
      t.string :payment_intent_token, null: false
      t.string :payment_status, null: false

      t.timestamps
    end
  end
end
