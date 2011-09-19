class AddPhotoVideoToNewsPosts < ActiveRecord::Migration
  def self.up
    add_column :news_posts, :image_file_name, :string
    add_column :news_posts, :image_content_type, :string
    add_column :news_posts, :image_file_size, :integer
    add_column :news_posts, :image_updated_at, :datetime
    add_column :news_posts, :video_url, :string
  end

  def self.down
    remove_column :news_posts, :video_url
    remove_column :news_posts, :image_updated_at
    remove_column :news_posts, :image_file_size
    remove_column :news_posts, :image_content_type
    remove_column :news_posts, :image_file_name
  end
end
