class RemoveTypeFromSmacks < ActiveRecord::Migration
  def self.up
    remove_column :smacks, :photo_post
  end

  def self.down
    add_column :smacks, :photo_post, :string
  end
end
