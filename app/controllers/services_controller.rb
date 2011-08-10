class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

#include SessionsHelper  
  
  def index
    # get all authentication services assigned to the current user
    @services = current_user.services.all
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    @service.destroy

    redirect_to services_path
  end
  
  # POST from signup view
=begin (not sure I need the new account feature)
   def newaccount
     if params[:commit] == "Cancel"
       session[:authhash] = nil
       session.delete :authhash
       redirect_to root_url
     else # create account
       @newuser = User.new
       @newuser.name = session[:authhash][:name]
       @newuser.email = session[:authhash][:email]
       @newuser.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])

       if @newuser.save!
         # signin existing user
         # in the session his user id and the service id used for signing in is stored
         session[:user_id] = @newuser.id
         session[:service_id] = @newuser.services.first.id

         flash[:success] = 'Your account has been created and you have been signed in!'
         redirect_to user_path
       else
         flash[:error] = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
         redirect_to user_path
       end
     end
   end
=end
   # Sign out current user
   
=begin   
   def signout
     if current_user
       session[:user_id] = nil
       session[:service_id] = nil
       session.delete :user_id
       session.delete :service_id
       sign_out
       flash[:success] = 'You have been signed out!'
     end
     redirect_to root_url
   end
=end
 
  
   # callback: success
   # This handles signing in and adding an authentication service to existing accounts itself
   # It renders a separate view if there is a new user to create

   def create  
     omniauth = request.env["omniauth.auth"]  
     authentication = Service.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
     if authentication  
       flash[:notice] = "Signed in successfully."  
       sign_in_and_redirect(:user, authentication.user)  
     elsif current_user  
       current_user.services.create(:provider => omniauth['provider'], :uid => omniauth['uid'])  
       flash[:notice] = "Authentication successful."  
       redirect_to services_url  
     else  
       flash[:error] = "You must sign-up with Campusmack before logging in with an alternate provider."
       redirect_to new_user_registration_path
     end  
   end
   
     # callback: failure
     def failure
       flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
       redirect_to root_url
     end
   end
  
