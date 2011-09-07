class Post < ActiveRecord::Base

  include PostsHelper
  #Through the 'make_voteable' gem
  #make_voteable

  #Through the 'thumbs_up' gem
  acts_as_voteable

  #Through the 'acts_as_commentable' gem
  acts_as_commentable

  attr_accessible :title, :summary, :vote, :on_frontpage_week, :video_attributes, :photo_attributes, :news_post_attributes, :statistic_attributes

  attr_searchable :title, :summary, :type

  belongs_to :postable, :polymorphic => true
  has_one :photo, :dependent => :destroy
  has_one :video, :dependent => :destroy
  has_one :statistic, :dependent => :destroy
  has_one :news_post, :dependent => :destroy

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy

  accepts_nested_attributes_for :video
  accepts_nested_attributes_for :photo
  accepts_nested_attributes_for :news_post
  accepts_nested_attributes_for :statistic

  validates :type, :presence => true
  validates :title, :presence => true

  scope :smacks, :conditions => ["posts.type LIKE ?", "Smack"]
  scope :redemptions, :conditions => ["posts.type LIKE ?", "Redemption"]
  scope :smack_of_week, :conditions => ["posts.type LIKE ? AND on_frontpage_week = ?", "Smack", Date.today.cweek], :limit => 1
  scope :by_conference, lambda { |conf| { :joins => :college, :conditions => [ 'conference = ?', conf ] } }

  default_scope :order => 'created_at DESC'

end
