class ContactGroupsContact < ActiveRecord::Base
  belongs_to :contact
  belongs_to :contact_group

  validates :contact_id, :uniqueness => {:scope => :contact_group_id}

  def self.add_group_contacts(group_id, contact_ids)
    contacts_saved_in_group = []
    contact_ids.each do |contact_id|
      contacts_in_group = ContactGroupsContact.new(:contact_id => contact_id ,:contact_group_id => group_id)
      contacts_in_group.save()
      contacts_saved_in_group << contacts_in_group
    end
  end
end
