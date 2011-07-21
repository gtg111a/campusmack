class RemoveStuffFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :photo_file
    remove_column :posts, :photo_medium_file
    remove_column :posts, :photo_thumb_file
  end

  def self.down
    add_column :posts, :photo_file, :binary
    add_column :posts, :photo_medium_file, :binary
    add_column :posts, :photo_thumb_file, :binary
  end
end
