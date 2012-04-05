source 'http://rubygems.org'

gem 'rails', '3.2.1'

group :assets do
  gem 'sass-rails', '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.1'

gem 'will_paginate', '3.0.3'

gem 'paperclip'
gem 'thin'
gem 'rack'
gem 'thumbs_up', '0.4.6'
gem 'rake'
gem 'acts_as_commentable'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-openid'
gem 'oa-core'
gem 'devise'
gem 'meta_search'
gem 'client_side_validations'
gem 'cancan'
gem 'fastercsv'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'breadcrumbs'
gem 'gravatar_image_tag'
gem 'profanalyzer'
gem 'aws-s3'
gem 'aws-sdk'
# newer version seems to cause "OpenURI::HTTPError Exception: 400 Bad Request" error
gem 'video_info', '0.2.6'

gem 'bitsontherun'
gem 'ckeditor', '3.6.3'

group :development do
  gem 'sqlite3'
  #gem 'mysql2', '0.2.8'
  gem 'rails_best_practices'
  gem 'annotate'
  gem 'heroku'
  gem 'taps'
  gem 'ruby-debug19'
end

group :test do
  gem 'spork'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'watchr'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

gem 'ffaker'
gem 'factory_girl_rails'

group :development, :test do
  gem 'sqlite3'
  gem 'launchy'
end

group :staging, :production do
  gem 'pg'
end
