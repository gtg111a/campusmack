class DropRedemptionsTable < ActiveRecord::Migration
  def self.up
     drop_table :redemptions
  end

  def self.down
  end
end
