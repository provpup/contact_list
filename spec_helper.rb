require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'rspec'
require 'rspec/collection_matchers'
require 'rack/test'
require 'json_spec'

require 'factory_girl'
require 'faker'
require 'database_cleaner'
require 'dotenv'
Dotenv.load

require_relative 'config/environment'
require_relative 'factories'

# Recreate the database
ActiveRecord::Migration.suppress_messages do
  require_relative 'db/schema'
end

module RackTestMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|

   #config.use_transactional_examples = false
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include JsonSpec::Helpers

  config.mock_with(:rspec) do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end
end

I18n.enforce_available_locales = false
