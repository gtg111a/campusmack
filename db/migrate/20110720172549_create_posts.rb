class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :summary
      t.string :type
      t.boolean :published
      t.references :postable, :polymorphic => true
      t.references :user
      t.integer :on_frontpage_week
      t.integer :report_count
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
