class AddContestToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :contest, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :contest
  end
end
