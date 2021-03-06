# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '2.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( twitter/bootstrap.js )
Rails.application.config.assets.precompile += %w( bootstrap-datepicker.js )

#Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( basestyle.css )
Rails.application.config.assets.precompile += %w( hoh_style.css )
Rails.application.config.assets.precompile += %w( bootstrap_and_overrides.css )
Rails.application.config.assets.precompile += %w( bootstrap-datepicker.css )


#Rails.application.config.assets.precompile += %w( calendar_date_select/calendar_date_select.js )
#Rails.application.config.assets.precompile += %w( calendar_date_select/red.css )
