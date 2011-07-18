class AddStuffToRedemptions < ActiveRecord::Migration
  def self.up
    add_column :redemptions, :type, :string
    add_column :redemptions, :content_type, :string
    add_column :redemptions, :title, :string
    add_column :redemptions, :content, :string
    add_column :redemptions, :vote, :integer
  end

  def self.down
    remove_column :redemptions, :vote
    remove_column :redemptions, :title
    remove_column :redemptions, :content
    remove_column :redemptions, :content_type
    remove_column :redemptions, :type
  end
end
