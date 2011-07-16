class College < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posts, :dependent => :destroy
  
  validates :name, :presence => true
  
end
