class AddDefaultValueToPublished < ActiveRecord::Migration
  def self.up
    change_column_default(:posts, :published, true)
    Post.update_all([ 'published = ?', true ], [ 'published IS NULL AND type != ?', "ArticlePost" ])
    Post.update_all([ 'published = ?', false ], [ 'published IS NULL AND type = ?', "ArticlePost" ])
  end

  def self.down
  end
end
