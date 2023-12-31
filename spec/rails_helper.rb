require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'mongoid-rspec'
require 'shoulda/matchers'


module ResponseJSON
  def response_json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path                               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures                 = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order                                      = 'random'
  config.use_active_record                          = false
  config.include ResponseJSON
  config.include Mongoid::Matchers, type: :model

  config.include FactoryBot::Syntax::Methods
  config.before :all do
    FactoryBot.reload
  end

  config.expect_with(:rspec) { |c| c.syntax = %i[should expect] }

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
