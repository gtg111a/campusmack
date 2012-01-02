class RenameLowercaseInConferences < ActiveRecord::Migration
  def self.up
    rename_column :conferences, :lowername, :permalink
  end

  def self.down
    rename_column :conferences, :permalink, :lowername
  end
end
