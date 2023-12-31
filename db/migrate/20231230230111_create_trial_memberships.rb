class CreateTrialMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :trial_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
