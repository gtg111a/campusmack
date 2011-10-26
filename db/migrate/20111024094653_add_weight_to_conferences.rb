class AddWeightToConferences < ActiveRecord::Migration
  def self.up
    add_column :conferences, :weight, :integer, :default => 0
  end

  def self.down
    remove_column :conferences, :weight
  end
end
