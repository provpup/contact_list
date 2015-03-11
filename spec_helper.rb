require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'rspec/collection_matchers'
require 'rack/test'

require 'factory_girl'
require 'faker'
require 'database_cleaner'
require 'dotenv'
Dotenv.load

require_relative 'app/models/contact'
require_relative 'app/models/phone_number'
require_relative 'factories'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  host:     db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: 'utf8'
)

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

  config.mock_with(:rspec) do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end
end

I18n.enforce_available_locales = false
