class Post < ActiveRecord::Base
  before_destroy :decrement_counter_cache

  include PostsHelper
  include Filter
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
  has_many :reports, :as => :reportable, :dependent => :destroy

  accepts_nested_attributes_for :video
  accepts_nested_attributes_for :photo
  accepts_nested_attributes_for :news_post
  accepts_nested_attributes_for :statistic

  validates :type, :presence => true
  validates :title, :presence => true

  scope :smacks, :conditions => ["posts.type LIKE ?", "Smack"]
  scope :redemptions, :conditions => ["posts.type LIKE ?", "Redemption"]
  scope :smacks_of_week, :conditions => ["posts.type LIKE ? AND on_frontpage_week = ?", "Smack", Date.today.cweek], :limit => 3
  scope :by_conference, lambda { |conf| { :joins => :college, :conditions => ['conference = ?', conf] } }

  def photo_url(params=nil)
    self.photo.image.url(params)
  end

  def decrement_counter_cache
    self.postable.class.decrement_counter "#{self.type.downcase.pluralize}_count", self.id
  end

  def youtube_thumbnail_url
    video_id = URI.parse(self.video.url).query.split('=')[1].to_s.slice(0, 11)
    return 'http://img.youtube.com/vi/' + video_id + '/0.jpg'
  end

end
