class AddStuffToSmacks < ActiveRecord::Migration
  def self.up
    add_column :smacks, :type, :string
    add_column :smacks, :content_type, :string
    add_column :smacks, :title, :string
    add_column :smacks, :content, :string
    add_column :smacks, :vote, :integer
  end

  def self.down
    remove_column :smacks, :vote
    remove_column :smacks, :title
    remove_column :smacks, :content
    remove_column :smacks, :content_type
    remove_column :smacks, :type
  end
end
