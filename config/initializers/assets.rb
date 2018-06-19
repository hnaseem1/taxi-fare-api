# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( user.js )
Rails.application.config.assets.precompile += %w( session.js )
Rails.application.config.assets.precompile += %w( google.js )
Rails.application.config.assets.precompile += %w( base.scss )
Rails.application.config.assets.precompile += %w( about.scss )
Rails.application.config.assets.precompile += %w( application.css )
Rails.application.config.assets.precompile += %w( documentations.scss )
Rails.application.config.assets.precompile += %w( google.scss )
Rails.application.config.assets.precompile += %w( reset.scss )
Rails.application.config.assets.precompile += %w( sessions.scss )
Rails.application.config.assets.precompile += %w( users.scss )
