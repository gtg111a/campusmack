class ChangeArticleSummaryToText < ActiveRecord::Migration
  def self.up
    change_column :posts, :summary, :text
  end
end
