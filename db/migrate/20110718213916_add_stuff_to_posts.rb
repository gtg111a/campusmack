class AddStuffToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :college_id, :integer
  end

  def self.down
    remove_column :posts, :college_id, :integer
  end
end
