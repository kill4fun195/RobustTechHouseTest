require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RobustTechHouseTest
  class Application < Rails::Application
    config.paths.add File.join("app", "api"), glob: File.join("**", "*.rb")
    config.autoload_paths += Dir[Rails.root.join("app", "api", "*")]
    config.autoload_paths += Dir[Rails.root.join("app", "services", "*")]
    config.autoload_paths += Dir[Rails.root.join("lib")]
    config.eager_load_paths << "#{Rails.root}/lib"
    config.middleware.use(Rack::Config) do |env|
      env["api.tilt.root"] = Rails.root.join("app", "views", "api")
    end
  end
end
