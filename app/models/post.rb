class Post < ActiveRecord::Base
  
  attr_accessible :content_type, :title, :content, :comments, :vote
  
  belongs_to :college
  
  has_many :smacks, :as => :apost, :dependent => :destroy
  has_many :redemptions, :as => :apost, :dependent => :destroy
  
  
 # validates :post_type,     :presence => true
  validates :type,          :presence => true
  validates :content_type,  :presence => true
  validates :title,         :presence => true
  validates :content,       :presence => true
  

  
end
