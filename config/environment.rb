# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Campusmack::Application.initialize!

Rails::Initializer.run do |config|
  config.action_controller.default_charset = "utf-8"
end

