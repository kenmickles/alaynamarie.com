# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "capybara/rspec"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Make FactoryGirl methods first-class citizens in RSpec
  config.include FactoryGirl::Syntax::Methods

  # include Capybara methods like visit
  config.include Capybara::DSL

  # enable caching by passing :caching => true into a describe block
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.around(:each, :caching) do |example|
    perform_caching = ActionController::Base.perform_caching
    cache_simple_records = Rails.configuration.cache_simple_records

    ActionController::Base.perform_caching = example.metadata[:caching]
    example.run

    ActionController::Base.perform_caching = perform_caching
    Rails.configuration.cache_simple_records = cache_simple_records
  end

  # cleanup after paperclip
  config.after :all do
    s3 = AWS::S3.new(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])
    s3.buckets[ENV['S3_BUCKET']].objects.each do |object|
      object.delete if object.key.match(/^test\//)
    end
  end
end