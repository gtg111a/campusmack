class AddCounters < ActiveRecord::Migration
  def self.up
    add_column :users, :posts_count, :integer, :default => 0
    add_column :users, :deliveries_count, :integer, :default => 0
    add_column :colleges, :users_count, :integer, :default => 0
    User.all.each { |u| User.reset_counters u.id, :posts, :deliveries }
    College.all.each { |c| College.reset_counters c.id, :users }
  end

  def self.down
    remove_column :users, :posts_count
    remove_column :users, :deliveries_count
    remove_column :colleges, :users_count
  end
end
