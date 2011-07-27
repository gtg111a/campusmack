class DropVotingsTable < ActiveRecord::Migration
  def self.up
    drop_table :votings
  end

  def self.down
  end
end
