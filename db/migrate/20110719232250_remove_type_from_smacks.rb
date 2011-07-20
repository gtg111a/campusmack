class RemoveTypeFromSmacks < ActiveRecord::Migration
  def self.up
    remove_column :smacks, :type
  end

  def self.down
    add_column :smacks, :type, :string
  end
end
