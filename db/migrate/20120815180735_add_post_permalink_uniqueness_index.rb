class AddPostPermalinkUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :posts, :permalink, :unique => true
  end

  def down
    remove_index :posts, :permalink
  end
end
