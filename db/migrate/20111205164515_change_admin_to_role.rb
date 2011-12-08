class ChangeAdminToRole < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :default => "user"
    User.reset_column_information
    User.all.each do |u|
      if u.admin
        u.role = "admin"
      else
        u.role = "user"
      end
      u.save
    end
    remove_column :users, :admin
  end

  def self.down
    add_column :users, :admin, :boolean, :default => false
    User.reset_column_information
    User.all.each do |u|
      u.admin = u.role == "admin"
      u.save
    end
    remove_column :users, :role
  end
end
