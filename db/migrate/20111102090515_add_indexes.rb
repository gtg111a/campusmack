class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :conferences, :permalink
    add_index :conferences, :division
    add_index :colleges, :permalink
    add_index :colleges, :conference_id
    add_index :posts, :postable_id
    add_index :posts, :postable_type
    add_index :posts, :user_id
    add_index :posts, :type
  end

  def self.down
  end
end
