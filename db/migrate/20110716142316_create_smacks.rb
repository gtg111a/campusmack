class CreateSmacks < ActiveRecord::Migration
  def self.up
    create_table :smacks do |t|

      t.timestamps
      t.string   :type
      t.string   :content_type
      t.string   :title
      t.string   :content
      t.integer  :vote
    end
  end

  def self.down
    drop_table :smacks
  end
end
