class FixPostsCommentsName < ActiveRecord::Migration
  def self.up
    rename_column :posts, :comments, :post_summary
  end

  def self.down
  end
end
