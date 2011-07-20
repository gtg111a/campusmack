class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :post_type
      t.string :content_type
      t.string :title
      t.string :content
      t.integer :vote
      t.integer :college_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
