require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'ffaker'
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  
  require 'factory_girl'
  Capybara.javascript_driver = :webkit
  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = false
        
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end
      
    config.before(:each) do
      DatabaseCleaner.start
    end
      
    config.after(:each) do
      DatabaseCleaner.clean
    end

  end
  def login(user)
    visit sign_in_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'password'
    click_button 'user_submit'
  end
  
  def handle_js_confirm(accept=true) # note: doesn't work with selenium
    page.evaluate_script "window.original_confirm_function = window.confirm"
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
  ensure
    page.evaluate_script "window.confirm = window.original_confirm_function"
  end
  
  def youtube_thumbnail(url)
    video_id = URI.parse(url).query.split('=')[1].slice(0, 11)
    return 'http://img.youtube.com/vi/' + video_id + '/0.jpg'
  end
  
end

Spork.each_run do
end

