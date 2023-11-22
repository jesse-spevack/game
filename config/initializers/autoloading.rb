# This is necessary to make autoloading work for the app/commands folder
# see https://github.com/rails/rails/pull/47583
module Commands; end
Rails.autoloaders.main.push_dir("#{Rails.root}/app/commands", namespace: Commands)
