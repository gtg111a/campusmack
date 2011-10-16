class AddLowernameToConferences < ActiveRecord::Migration
  def self.up
    add_column :conferences, :lowername, :string
  end

  def self.down
    remove_column :conferences, :lowername
  end
end
