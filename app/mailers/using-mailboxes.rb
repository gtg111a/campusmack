require 'mailgun'

Mailgun::init("key-0ujr7ogy6rvgdg24$4")

# creating a mailbox
mailbox = Mailbox.new(:user => 'new1', :domain => 'campusmack.mailgun.org', :password => 'campusmack')
mailbox.upsert()
mailbox.password = 'campusmack'
mailbox.upsert()

#upsert from csv (Don't have a csv setup)
#Mailbox.upsert_from_csv('up1@campusmack.mailgun.org,  321bca')

# print out all mailboxes
puts "Mailboxes:"
Mailbox.find(:all).each {|m| puts m.user + "@" + m.domain + " " + m.size}

