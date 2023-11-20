ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'
require 'simplecov'
require 'simplecov-console'
require 'mongoid-rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path                               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures                 = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order                                      = 'random'
  config.use_active_record                          = false
  config.expect_with(:rspec) { |c| c.syntax         = [:should, :expect] }

  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods
  config.include ControllerSpecHelper
  config.include RequestSpecHelper


  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before :all do
    FactoryBot.reload
  end

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each, type: :feature do
    DatabaseCleaner.strategy = :truncation, { pre_count: true }
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
