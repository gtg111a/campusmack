class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.references :post
      t.references :user
      t.references :college
      t.integer :recipients

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
