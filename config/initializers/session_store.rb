# Be sure to restart your server when you modify this file.

Campusmack::Application.config.session_store :cookie_store

Campusmack::Application.config.session = { 
  :key => '_campusmack_session',
  :domain => nil, # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month, # expire cookie
  :secure => false, # fore https if true
  :httponly => true, # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret => '43806c2e9840607637fd94de9614d4dc014e267d1f5b9c3edca800e278f8d96e51ab647f5a15004fab9851c6e167ee8c1c7470ea2672c3924e1ee4f92f4ad45d'
}


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Campusmack::Application.config.session_store :active_record_store
=begin
OmniauthDemo::Application.config.session = {
  :key => '_omniauthpure_session', # name of cookie that stores the data
  :domain => nil, # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month, # expire cookie
  :secure => false, # fore https if true
  :httponly => true, # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret => 'cb8e1ac9dd5f4d08974f9f4d74abb45239a98b6cc3c59829ce6b61280160c421b4c18b0a721c26e0b4f43c119587590262f0341821bf31fa5bf426d65236a394'
}
=end