class AddStuffToPosts < ActiveRecord::Migration
  def self.up
       add_column :posts, :comments, :string
    end

    def self.down
      add_column :posts, :comments
  end
end
