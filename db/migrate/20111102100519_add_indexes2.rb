class AddIndexes2 < ActiveRecord::Migration
  def self.up
    add_index :contact_groups_contacts, :contact_id
    add_index :contact_groups_contacts, :contact_group_id
    add_index :contacts, :user_id
  end

  def self.down
  end
end
