class RemoveTypeFromRedemptions < ActiveRecord::Migration
  def self.up
    remove_column :redemptions, :photo_post
  end

  def self.down
    add_column :redemptions, :photo_post, :string
  end
end
