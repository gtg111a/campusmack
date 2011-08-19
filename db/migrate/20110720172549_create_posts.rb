class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :content_type
      t.string :title
      t.string :content
      t.integer :college_id
      t.integer :user_id
      t.string :post_summary
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
