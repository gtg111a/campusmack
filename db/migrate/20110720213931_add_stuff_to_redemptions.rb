class AddStuffToRedemptions < ActiveRecord::Migration
  def self.up
      add_column :redemptions, :photo_post, :string
    end

    def self.down
      remove_column :redemptions, :photo_post

  end
end
