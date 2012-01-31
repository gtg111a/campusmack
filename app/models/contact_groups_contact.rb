class ContactGroupsContact < ActiveRecord::Base
  belongs_to :contact
  belongs_to :contact_group

  validates :contact_id, :uniqueness => {:scope => :contact_group_id}

  def self.add_group_contacts(group, contact_ids)
    if group.present? && !group.new_record?
      if contact_ids != nil
        contacts_saved_in_group = []
        cb = contact_ids.split(',')
        cb.each do |contact_id|
          contacts_in_group = ContactGroupsContact.new(:contact_id => contact_id.to_i ,:contact_group_id => group.id)
          begin
            contacts_in_group.save!
            contacts_saved_in_group << contacts_in_group
          rescue ActiveRecord::RecordInvalid
            # it is ok, if we already have this contact in this group
          end
        end
      end
    end
  end
end
