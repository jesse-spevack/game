class AddPlayerReferenceToResponses < ActiveRecord::Migration[7.1]
  def change
    add_reference :responses, :player, null: false, foreign_key: true
  end
end
