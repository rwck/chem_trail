source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


group :development do
  gem 'pry-rails'         # makes rails console nicer
  gem 'annotate'          # writes useful comments on your models
  gem 'quiet_assets'      # cleans up your logging output
  gem 'better_errors'     # explains itself... hopefully
  gem 'awesome_print'     # ap is like pp but nicer
end


group :test, :development do
  gem 'rspec-rails' # this is for testing
  gem 'simplecov', require: false # make sure it's installed but don't put it in automatically - you wnat to control this in the right way.
  gem 'factory_girl_rails'
end


# capybara etc
group :test, :development do
  gem 'capybara' #fill_in forms and click_buttons -- no javascript though
end

# nested form gem

gem 'nested_form'
gem 'puma'

group :test, :development do
  gem 'selenium-webdriver' # remote control for firefox
  gem 'database_cleaner' # conveniently truncate tables
  gem 'launchy' # like 'open' in the command line - enables the command save_and_open_page
end
