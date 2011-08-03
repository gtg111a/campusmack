class AddConferenceToColleges < ActiveRecord::Migration
  def self.up
    add_column :colleges, :conference, :string
  end

  def self.down
    remove_column :colleges, :conference
  end
end
