class AddCensorFilterToUsers < ActiveRecord::Migration
  def self.up
    add_column(:users, :censor_text, :boolean, :default => true)
  end

  def self.down
    remove_column(:users, :censor_text)
  end
end
