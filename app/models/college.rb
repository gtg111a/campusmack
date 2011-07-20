class College < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posts, :dependent => :destroy
  
  has_many :posts, :dependent => :destroy
  has_many :smacks, :dependent => :destroy
  has_many :redemptions, :dependent => :destroy
  
  validates :name, :presence => true
  
  accepts_nested_attributes_for :smacks
  accepts_nested_attributes_for :redemptions
  accepts_nested_attributes_for :posts
  
end
