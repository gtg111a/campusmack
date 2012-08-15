class AddPermalinkToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :permalink, :string

  end
end
