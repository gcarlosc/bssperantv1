require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bssperantv1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.autoload_paths += [config.root.join("app")]
    # config.eager_load_paths += [config.root.join("app")]
    # config.autoload_paths += [config.root.join("app/loggers")]
    # config.eager_load_paths += [config.root.join("app/loggers")]
    config.load_defaults 6.1


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_job.queue_adapter = :delayed_job
    # config.logger = Post.new
    # config.logger = CustomLogger.new(Rails.root.join("log", "#{Rails.env}.log"))
    # config.log_level = :debug
  end
end
