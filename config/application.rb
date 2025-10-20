require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module EasyApp
  class Application < Rails::Application

    config.load_defaults 8.0
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.autoload_lib(ignore: %w[assets tasks])

  end
end
