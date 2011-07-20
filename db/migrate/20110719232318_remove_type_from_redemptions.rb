class RemoveTypeFromRedemptions < ActiveRecord::Migration
  def self.up
    remove_column :redemptions, :type
  end

  def self.down
    add_column :redemptions, :type, :string
  end
end
