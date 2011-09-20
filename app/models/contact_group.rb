class ContactGroup < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :contacts

  validates :name, :uniqueness => {:scope => :user_id}

  def self.add_to_groupmodel( user,new_group_name)
    saved_in_group=[]

      new_group = user.contact_groups.new(:name=>new_group_name.strip)
      new_group.save()

    return saved_in_group<<new_group;
  end
end
