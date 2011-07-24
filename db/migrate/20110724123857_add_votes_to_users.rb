class AddVotesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :up_votes, :integer
    add_column :users, :down_votes, :integer
  end

  def self.down
    remove_column :users, :down_votes
    remove_column :users, :up_votes
  end
end
