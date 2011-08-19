class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :content_type
      t.string :title
      t.string :content
      t.integer :college_id
      t.integer :user_id
      t.string :post_summary
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
