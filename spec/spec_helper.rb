# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'rails'
require 'action_controller/railtie'
require 'dry-schema'
require 'rspec/rails'
require 'support/coverage_loader'

require 'sealink-param-validation'

module SealinkParamValidation
  class Application < Rails::Application
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!

  config.order = :random unless ENV.key? 'NO_RANDOM_ORDER'

  config.before :suite do
    srand RSpec.configuration.seed
  end
end
