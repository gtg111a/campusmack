class CreateNewsPost < ActiveRecord::Migration
  def self.up
    create_table :news_posts do |t|
      t.references :post
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :news_posts
  end
end
