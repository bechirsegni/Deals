# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( validate.js , js/map_contact.js , js/infobox.js, js/cat_nav_mobile.js)
Rails.application.config.assets.precompile += %w( css/date_time_picker.css )
Rails.application.config.assets.precompile += %w( css/skins/square/grey.css )
Rails.application.config.assets.precompile += %w( css/ion.rangeSlider.css )
Rails.application.config.assets.precompile += %w( js/bootstrap-datepicker.js , js/map_restaurants.js)
Rails.application.config.assets.precompile += %w( js/datepicker_advanced.js)
Rails.application.config.assets.precompile += %w( js/icheck.js )
Rails.application.config.assets.precompile += %w( css/ion.rangeSlider.skinFlat.css )
Rails.application.config.assets.precompile += %w( js/infobox.js )