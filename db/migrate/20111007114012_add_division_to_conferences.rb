class AddDivisionToConferences < ActiveRecord::Migration
  def self.up
    add_column :conferences, :division, :string
  end

  def self.down
    remove_column :conferences, :division
  end
end
