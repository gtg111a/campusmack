class AddOnFrontpageToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :on_frontpage_week, :integer
  end

  def self.down
    drop_column :posts, :on_frontpage_week
  end
end
