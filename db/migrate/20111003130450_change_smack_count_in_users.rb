class ChangeSmackCountInUsers < ActiveRecord::Migration
  def self.up
    change_column(:users, :smack_count, :integer , :default => 0)
  end

  def self.down
  end
end
