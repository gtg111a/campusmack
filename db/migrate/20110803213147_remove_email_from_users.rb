class RemoveEmailFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :password_salt
  end

  def self.down
    add_column :users, :email, :string
  end
end
