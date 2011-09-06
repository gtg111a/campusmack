class AddCountersToPostable < ActiveRecord::Migration
  def self.up
    add_column :colleges, :smacks_count, :integer, :null => false, :default => 0
    add_column :colleges, :redemptions_count, :integer, :null => false, :default => 0
    add_column :conferences, :smacks_count, :integer, :null => false, :default => 0
    add_column :conferences, :redemptions_count, :integer, :null => false, :default => 0
    
    College.reset_column_information
    College.all.each do |c|
      College.update_counters c.id, :smacks_count => c.smacks.length
      College.update_counters c.id, :redemptions_count => c.redemptions.length
    end
    Conference.reset_column_information
    Conference.all.each do |c|
      Conference.update_counters c.id, :smacks_count => c.smacks.length
      Conference.update_counters c.id, :redemptions_count => c.redemptions.length
    end
    
  end

  def self.down
    remove_column :colleges, :smacks_count
    remove_column :colleges, :redemptions_count
    remove_column :conferences, :smacks_count
    remove_column :conferences, :redemptions_count
  end
end
