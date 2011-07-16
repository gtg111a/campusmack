class Post < ActiveRecord::Base
  
  attr_accessible :type, :content_type, :title, :content, :comments, :vote
  belongs_to :college
  
  validates :content,       :presence => true
  validates :type,          :presence => true
  validates :content_type,  :presence => true
  validates :title,         :presence => true
  validates :content,       :presence => true
  
end
