source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass', branch: '3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'


group :development do
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'pg'
end

gem 'rspec-rails', group: [:development, :rails]

group :production do
  gem 'pg'
end
