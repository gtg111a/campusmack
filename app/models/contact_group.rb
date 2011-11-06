class ContactGroup < ActiveRecord::Base
  belongs_to :user

  has_many :contact_groups_contact
  has_many :contacts, :through => :contact_groups_contact
  validates :name, :uniqueness => {:scope => :user_id}, :presence => true

  def self.add_to_groupmodel(user, new_group_name)
    new_group = user.contact_groups.new(:name => new_group_name.strip)
    new_group.save()

    return new_group;
  end

  def self.group_emails_check_box(user, group_id )
    @contacts = []
    if group_id != '0'
      @contacts =  user.contact_groups.find(group_id).contacts
    else
      @contacts =  user.contacts.all
    end
    return @contacts
  end
end


# == Schema Information
#
# Table name: contact_groups
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

