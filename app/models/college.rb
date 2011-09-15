class College < ActiveRecord::Base
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy
  belongs_to :conference
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
