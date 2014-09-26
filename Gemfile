source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.17'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '~> 3.0.0'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.0'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


group :doc do
  gem 'sdoc', '0.3.20', require: false
end

gem 'jquery-rails'

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end