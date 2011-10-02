class AddSmackCountToUsers < ActiveRecord::Migration
  def self.up
    add_column(:users, :smack_count, :integer)
  end

  def self.down
      remove_column(:users, :smack_count)
  end
end
