class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :user
      t.references :reportable, :polymorphic => true
      t.references :reason
      t.string :custom_reason

      t.timestamps
    end
    
    add_index :reports, :reportable_type
    add_index :reports, :reportable_id
    add_index :reports, :user_id
    
    add_column :comments, :reports_count, :integer, :null => false, :default => 0
    remove_column :posts, :report_count
    add_column :posts, :reports_count, :integer, :null => false, :default => 0
  end

  def self.down
    drop_table :reports
    remove_column :posts, :reports_count
    remove_column :comments, :reports_count
    add_column :posts, :report_count, :integer
  end
end
