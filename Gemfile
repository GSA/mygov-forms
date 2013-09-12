source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'cancan'
gem "cocoon"
gem 'country-select'
gem 'formtastic-bootstrap', git: 'https://github.com/jgrevich/formtastic-bootstrap.git', branch: 'bootstrap3'
gem 'haml-rails'
gem 'httparty'
gem 'json', "~> 1.7.7"
gem 'jquery-rails'
gem 'mysql2'
gem 'omniauth-myusa', :git => 'https://github.com/GSA-OCSIT/omniauth-myusa.git'
gem 'secure_headers'
gem 'rolify'
gem 'redcarpet'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'capistrano'
  gem 'guard-livereload'
  gem 'quiet_assets'
  gem 'thin'
end

group :development, :test do
  gem 'awesome_print'
  gem 'capybara-accessible', :github => 'jgrevich/capybara-accessible', :branch => 'WIP-granulated_aria_tests'
  gem 'guard'
  gem 'guard-rspec'
  gem "parallel_tests"
  gem 'pry'
  gem 'pry-nav'
#  gem 'pry-rescue'
#  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem "zeus-parallel_tests"
  gem 'factory_girl_rails'
  gem "brakeman", :require => false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'libnotify'
  gem 'shoulda-matchers'
#  gem 'simplecov', :require => false
  gem 'webmock'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
