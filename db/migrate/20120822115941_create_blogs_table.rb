class CreateBlogsTable < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :name
      t.timestamps
      t.string :permalink
    end
  end

  def self.down
    drop_table :blogs
  end
end
