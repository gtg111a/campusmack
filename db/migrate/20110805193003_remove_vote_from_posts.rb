class RemoveVoteFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :vote
    remove_column :posts, :up_votes
    remove_column :posts, :down_votes
  end

  def self.down
    add_column :posts, :down_votes, :integer
    add_column :posts, :up_votes, :integer
    add_column :posts, :vote, :integer
  end
end
