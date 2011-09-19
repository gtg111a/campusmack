class ContactGroup < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :contacts

  #validates :name, :uniqueness => {:scope => :user_id}

  def self.add_to_groupmodel( user, group_type, group_id, contact_ids, new_group_name)
    contacts_saved_in_group=[]
    if group_type=="existing"
      if contact_ids.present?
        contact_ids.each do |contact_id|
          contacts_in_group =  ContactGroupsContact.new(:contact_id=>contact_id ,:contact_group_id=>group_id['id'] )
          contacts_in_group.save()
          contacts_saved_in_group<<contacts_in_group
        end
      else
        puts "please Select contacts"
      end
    else 
      if new_group_name.present? && new_group_name.strip !=''
         new_group = user.contact_groups.new(:name=>new_group_name)
         new_group.save()
        if contact_ids.present?
          contact_ids.each do |contact_id|
            contacts_in_group = ContactGroupsContact.new(:contact_id=>contact_id ,:contact_group_id=>new_group.id )
            contacts_in_group.save()
            contacts_saved_in_group<<contacts_in_group
          end
        else
          puts "please Select contacts"
        end

      else
        puts 'please give a group name'
      end
      return contacts_saved_in_group;
    end


    
  end
end
