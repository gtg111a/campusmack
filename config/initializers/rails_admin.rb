
RailsAdmin.config do |config|
  config.authorize_with :cancan

  config.model Post do
    visible false
  end

end
