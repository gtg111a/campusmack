class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.string :email
      t.string :first_name
      t.string :last_name
      t.boolean :admin, :default => false
      t.string :college
      t.string :affiliation
      t.integer :up_votes
      t.integer :down_votes

      t.database_authenticatable :null => false
      t.recoverable
      t.confirmable
      t.rememberable
      t.trackable

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end

end
