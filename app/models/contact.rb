class Contact < ActiveRecord::Base
  belongs_to :user

  has_many :contact_groups_contact
  has_many :contact_groups, :through => :contact_groups_contact

  validates :email, :uniqueness => {:scope => :user_id}, :presence => true
  validates :user_id, :presence => true

  def self.import (user, emails_csv)
    puts emails_csv
    puts user
    emails = emails_csv.split(',')
    imported_contacts = []
    emails.each() do |email|
      pattern = /"(.*)" <(.*)>/
      match = pattern.match(email.strip)
      name = ""
      name = match[1] if(match.present?)
      parsed_email = email.strip
      parsed_email = match[2] if(match[2].present?)
      contact = user.contacts.new(:email => parsed_email, :name => name)
      contact.save
      imported_contacts << contact
    end
    return imported_contacts
  end

  def name_or_email
    name.empty? ? email : name
  end

  def self.search(search)
    if search
      where 'name LIKE ? or email LIKE ?', "%#{search}%", "%#{search}%"
    else
      scoped
    end
  end

end


# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  user_id    :integer         indexed
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_contacts_on_user_id  (user_id)
#

