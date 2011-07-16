class CreateSmacks < ActiveRecord::Migration
  def self.up
    create_table :smacks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :smacks
  end
end
