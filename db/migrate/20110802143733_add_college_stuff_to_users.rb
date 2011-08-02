class AddCollegeStuffToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :college, :string
    add_column :users, :affiliation, :string
  end

  def self.down
    remove_column :users, :affiliation
    remove_column :users, :college
  end
end
