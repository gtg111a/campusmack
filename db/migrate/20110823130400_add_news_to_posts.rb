class AddNewsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :news, :string
  end

  def self.down
    remove_column :posts, :news
  end
end
