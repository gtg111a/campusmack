class ContactGroupsContact < ActiveRecord::Base
  belongs_to :contact
  belongs_to :contact_group

  validates :contact_id, :uniqueness => {:scope => :contact_group_id}

  def self.add_group_contacts group_Id,contact_Ids
    contacts_saved_in_group=[]
    contact_Ids.each do |contact_id|
      contacts_in_group =  ContactGroupsContact.new(:contact_id=>contact_id ,:contact_group_id=>group_Id )
      contacts_in_group.save()
      contacts_saved_in_group<<contacts_in_group
    end
  end
end
