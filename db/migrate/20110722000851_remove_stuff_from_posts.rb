class RemoveStuffFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :post_type

  end

  def self.down
    add_column :posts, :post_type, :string
  end
end
