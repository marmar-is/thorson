# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "plugins")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")

# General Assets (js)
Rails.application.config.assets.precompile += %w(
bootstrap/js/bootstrap.min.js
jquery.easing/jquery.easing.min.js
perfect-scrollbar/js/perfect-scrollbar.jquery.min.js
accordion.js
animate.js
link-transition.js
panel-controls.js
preloader.js
toggle.js
urban-constants.js
lib.js
)

# New Risk Profile (css & js)
Rails.application.config.assets.precompile += %w(
chosen_v1.4.0/chosen.min.css
chosen_v1.4.0/chosen.jquery.min.js
)
