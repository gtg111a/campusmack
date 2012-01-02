class AddUsernameIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :username
  end

  def self.down
  end
end
