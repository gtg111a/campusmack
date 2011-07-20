class AddStuffToSmacks < ActiveRecord::Migration
  def self.up
    add_column :smacks, :apost_type, :string
  end

  def self.down
    remove_column :smacks, :apost_type
  end
end
