class AddStuffToSmacks < ActiveRecord::Migration
  def self.up
    add_column :smacks, :photo_post, :string
  end

  def self.down
    remove_column :smacks, :photo_post
  end
end
