class AddVotesCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :up_votes, :integer, :null => false, :default => 0
    add_column :posts, :down_votes, :integer, :null => false, :default => 0
    
    Post.all.each do |p|
      p.up_votes = p.votes.where(:vote => true).count
      p.down_votes = p.votes.where(:vote => false).count
      p.save
    end
  end

  def self.down
    remove_column :posts, :down_votes
    remove_column :posts, :up_votes
  end
end
