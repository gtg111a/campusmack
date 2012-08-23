class AddSmacksCountToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :smacks_count, :integer
  end
end
