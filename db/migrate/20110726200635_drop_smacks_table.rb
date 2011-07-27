class DropSmacksTable < ActiveRecord::Migration
  def self.up
     drop_table :smacks
  end

  def self.down
  end
end
