class RemoveSmackCountFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :smack_count
  end

  def self.down
  end
end
