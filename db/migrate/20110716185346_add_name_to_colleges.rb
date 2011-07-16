class AddNameToColleges < ActiveRecord::Migration
  def self.up
    add_column :colleges, :name, :string
  end

  def self.down
    remove_column :colleges, :name
  end
end
