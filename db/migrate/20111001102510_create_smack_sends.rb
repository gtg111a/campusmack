class CreateSmackSends < ActiveRecord::Migration
  def self.up
    create_table :smack_sends do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :smack_sends
  end
end
