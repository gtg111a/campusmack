require 'mailgun'

Mailgun::init("key-0ujr7ogy6rvgdg24$4")

# creating a route: (don't need this yet)
#route = Route.new(:pattern => 'campusmack.mailgun.org', :destination => 'http://campusmack.mailgun.org/post')
#route.upsert()

# print out all routes:
puts "Routes:"
Route.find(:all).each {|r| puts r.pattern + "\t==> " + r.destination}
