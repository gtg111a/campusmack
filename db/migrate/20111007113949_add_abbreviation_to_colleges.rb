class AddAbbreviationToColleges < ActiveRecord::Migration
  def self.up
    add_column :colleges, :abbrev, :string
  end

  def self.down
    remove_column :colleges, :abbrev
  end
end
