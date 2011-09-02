class AddReportCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :report_count, :integer
  end

  def self.down
    remove_column :posts, :report_count
  end
end
