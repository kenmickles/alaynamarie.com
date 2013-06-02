source 'http://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.13'

gem 'mysql2'
gem 'aws-sdk'
gem "paperclip", "~> 2.3"
gem 'slim'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'rdiscount'
gem 'dalli'
gem 'memcachier'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails', '~> 3.2.5'
  gem 'bootstrap-sass', '~> 2.3.1.0'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '~> 1.3.0'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rb-fsevent'
  gem 'turn', '0.8.2', :require => false
end

group :production do
  gem 'pg'
end
