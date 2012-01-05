class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.references :post
      t.text :body
      t.string :video_url
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
