require 'rspec'
require 'simplecov'
require 'colorize'
require 'mercadopago'
require 'factory_girl'
require 'tempfile'

SimpleCov.start

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.color = true
  FactoryGirl.find_definitions
end