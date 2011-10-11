class ContactGroup < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :contacts #, :dependent => :delete_all

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
