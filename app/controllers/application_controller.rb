class ApplicationController < ActionController::Base
  protect_from_forgery
  include PostsHelper
  include SessionsHelper
  
  before_filter :store_location, :only => [:index, :show]
  before_filter :store_location_edit, :only => [:index, :show]

end
