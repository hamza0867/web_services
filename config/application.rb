require File.expand_path('boot', __dir__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Triresults
  class Application < Rails::Application
    Mongoid.load!('./config/mongoid.yml')
    config.eager_load_paths += %W[#{config.root}/app/services]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
