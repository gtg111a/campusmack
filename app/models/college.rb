class College < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posts, :dependent => :destroy
  has_many :smacks, :dependent => :destroy
  has_many :redemptions, :dependent => :destroy
  
  validates :name, :presence => true
  
end
