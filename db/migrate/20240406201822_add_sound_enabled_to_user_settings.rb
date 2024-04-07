class AddSoundEnabledToUserSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :user_settings, :sound_enabled, :boolean, default: true
  end
end
