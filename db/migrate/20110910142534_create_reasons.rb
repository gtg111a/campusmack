class CreateReasons < ActiveRecord::Migration
  def self.up
    create_table :reasons do |t|
      t.string :reason

      t.timestamps
    end
    
    Reason.find_or_create_by_reason "Inapropriate content"
    Reason.find_or_create_by_reason "Offensive content"
    Reason.find_or_create_by_reason "Spam"
  end

  def self.down
    drop_table :reasons
  end
end
