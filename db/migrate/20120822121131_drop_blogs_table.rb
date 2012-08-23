class DropBlogsTable < ActiveRecord::Migration
  def up
    drop_table :blogs
  end

  def down
  end
end
