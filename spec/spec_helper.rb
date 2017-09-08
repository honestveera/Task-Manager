ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/mocks"
require "capybara/rspec"
require "vcr"
require "rails/application"
require "webmock/rspec"
require "shoulda/matchers"
require "capybara-screenshot/rspec"
require "pundit/rspec"
require 'simplecov'
require 'rails_helper'

ActiveRecord::Migration.maintain_test_schema!
WebMock.disable_net_connect!(allow_localhost: true)

Dir["./spec/page_object/**/sections/*.rb","./spec/page_object/**/pages/*.rb","./spec/support/**/*.rb"].each { |f| require f }


RSpec.configure do |config|
  SimpleCov.minimum_coverage 74
  SimpleCov.start "rails"

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include Capybara::DSL
  # config.include Features::SessionHelpers, type: :feature
  config.include FactoryGirl::Syntax::Methods
  # config.include Request::JsonHelpers, type: :request
  # config.include Request::AuthenticationHelpers, type: :request
  config.extend VCR::RSpec::Macros
  # config.include APIMatchers::RSpecMatchers
  # config.include PageContentsHelper, type: :feature

  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!


  #Differnt browser configuration
  driver = ENV['DRIVER'].try(:to_sym)

  if driver.nil? || driver == :webkit
    Capybara.default_driver = :webkit
    Capybara.current_driver = :webkit
    Capybara.javascript_driver = :webkit
  elsif driver == :selenium
    Capybara.default_driver = :selenium
    Capybara.current_driver = :selenium
    Capybara.javascript_driver = :selenium
  elsif driver == :poltergeist
    require 'capybara/poltergeist'
    Capybara.default_driver = :poltergeist
    Capybara.current_driver = :poltergeist
    Capybara.javascript_driver = :poltergeist
  elsif driver == :chrome
    Capybara.register_driver :chrome do |app|
     Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    Capybara.default_driver = :chrome
    Capybara.current_driver = :chrome
    Capybara.javascript_driver = :chrome
  else # to use chrome, for example, with selenium
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: driver)
    end
    Capybara.default_driver = :selenium
    Capybara.current_driver = :selenium
    Capybara.javascript_driver = :selenium
  end

  #Capybara Screenshot configuration
  Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
    "#{example.metadata[:example_group][:location].gsub!(/^.*(\\|\/)/, '')}"
  end

  Capybara.save_and_open_page_path = 'tmp/capybara'
  Capybara::Screenshot.prune_strategy = { keep: 10 }

  # http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  # Rspec need to run transactions and
  config.use_transactional_fixtures = false

  config.before(:each,type: :feature,js: true) do
    Capybara.page.driver.browser.manage.window.maximize
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    Dir["tmp/capybara/**"].each{|file| File.delete(file)}
    DatabaseCleaner.clean
  end
end
