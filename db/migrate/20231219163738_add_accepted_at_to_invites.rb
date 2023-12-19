class AddAcceptedAtToInvites < ActiveRecord::Migration[7.1]
  def change
    add_column :invites, :accepted_at, :datetime
  end
end
