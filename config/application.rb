require_relative 'boot'
require 'rails/all'
require 'csv'

Bundler.require(*Rails.groups)

module SAF
  class Application < Rails::Application

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    config.assets.initialize_on_precompile = false
  end

end
