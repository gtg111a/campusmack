class RemoveSmackSends < ActiveRecord::Migration
  def self.up
    drop_table :smack_sends
  end

  def self.down
  end
end
