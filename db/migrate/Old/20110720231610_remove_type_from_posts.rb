class RemoveTypeFromPosts < ActiveRecord::Migration
  def self.up
    drop_table :posts
  end

  def self.down
    create_table :posts
  end
end
