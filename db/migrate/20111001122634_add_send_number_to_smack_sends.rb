class AddSendNumberToSmackSends < ActiveRecord::Migration
  def self.up
     add_column(:smack_sends, :send_number, :integer)
  end

  def self.down
    remove_column(:smack_sends, :send_number)
  end
end
