class AddVoteableToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :up_votes, :integer
    add_column :posts, :down_votes, :integer
  end

  def self.down
    remove_column :posts, :down_votes
    remove_column :posts, :up_votes
  end
end
