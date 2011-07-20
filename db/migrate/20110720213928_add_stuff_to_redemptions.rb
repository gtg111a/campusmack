class AddStuffToRedemptions < ActiveRecord::Migration
  def self.up
      add_column :redemptions, :apost_type, :string
    end

    def self.down
      remove_column :redemptions, :apost_type

  end
end
