class Blog < ActiveRecord::Base
  
  has_many :users
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :article_posts, :as => :postable, :dependent => :destroy
  has_many :users
  validates :name, :presence => true

  accepts_nested_attributes_for :posts
  
  before_save :create_permalink
  
  def to_param
    self.permalink
  end

  def create_permalink
    return if name.nil?
    self.permalink = name.parameterize
  end
  
end
