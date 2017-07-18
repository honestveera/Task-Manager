source 'https://rubygems.org'

gem 'rails', '4.2.6'

#Assets Management Gems
gem 'bootstrap-sass'
gem 'bootstrap-select-rails'
gem 'therubyracer'
gem 'autoprefixer-rails'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'jquery-ui-rails'
gem "turbolinks"
gem "jquery-turbolinks"
gem 'jbuilder', '~> 2.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'haml-rails'

#Code Analysing gem
gem 'rubocop', require: false

#Documentation Gems
gem 'sdoc', '~> 0.4.0', group: :doc

#Rails console
gem 'pry-rails'

#User Management authrntication gem
gem 'devise'
gem 'mysql2', '~> 0.3.21'
gem 'puma'

#Continuous integration gem
gem 'travis'

#Free mail delivery mailgun
gem 'mailgun-ruby'

#BACKGROUND PROCESS MANAGE
gem 'delayed_job_active_record'

#Scheduling jobs
gem 'whenever', :require => false


group :production do
  gem 'heroku','3.43'
  gem 'pg'
  gem 'rails_12factor'

end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'byebug'
  gem 'foreman'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'html2haml'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'faker'
end