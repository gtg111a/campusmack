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

  attr_accessible :title, :summary, :vote, :on_frontpage_week, :published, :video_attributes, :photo_attributes, :news_post_attributes, :statistic_attributes, :article_attributes

  attr_searchable :title, :summary, :type

  belongs_to :postable, :polymorphic => true
  has_one :photo, :dependent => :destroy
  has_one :video, :dependent => :destroy
  has_one :statistic, :dependent => :destroy
  has_one :news_post, :dependent => :destroy
  has_one :article, :dependent => :destroy

  belongs_to :user, :counter_cache => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :reports, :as => :reportable, :dependent => :destroy

  accepts_nested_attributes_for :video
  accepts_nested_attributes_for :photo
  accepts_nested_attributes_for :news_post
  accepts_nested_attributes_for :statistic
  accepts_nested_attributes_for :article

  validates :type, :presence => true
  validates :title, :presence => true

  scope :published, where(published: true)
  scope :smacks, :conditions => ["posts.type LIKE ?", "Smack"]
  scope :redemptions, :conditions => ["posts.type LIKE ?", "Redemption"]
  scope :smacks_of_week, :conditions => ["posts.type LIKE ? AND on_frontpage_week = ?", "Smack", Date.today.cweek], :limit => 3
  scope :by_conference, lambda { |conf| { :joins => :college, :conditions => ['conference = ?', conf] } }

  DEFAULT_ORDER = 'created_at desc'
  PER_PAGE_DEFAULT = [25, 50, 100, 150]

  def self.default_order
    DEFAULT_ORDER
  end

  def photo_url(params=nil)
    if self.photo
      self.photo.image.url(params)
    elsif self.article
      self.article.image.exists? && self.article.image.url(params)
    end
  end

  def decrement_counter_cache
    self.postable.class.decrement_counter "#{self.type.downcase.pluralize}_count", self.id unless self.type == "ArticlePost"
    User.decrement_counter(:posts_count, self.id)
  end

  def youtube_thumbnail_url
    if self.video
      url = self.video.url
    elsif self.article
      url = self.article.video_url
    end
    if url =~ /(youtu|y2u)\.be/
      video_id = URI.parse(url).path.gsub(/\//, "") rescue nil
    else
      video_id = URI.parse(url).query.split('=')[1].slice(0, 11) rescue nil
    end
    return if video_id.nil?
    'http://img.youtube.com/vi/' + video_id + '/0.jpg'
  end

end



# == Schema Information
#
# Table name: posts
#
#  id                :integer(4)      not null, primary key
#  title             :string(255)
#  summary           :string(255)
#  type              :string(255)     indexed
#  published         :boolean(1)
#  postable_id       :integer(4)      indexed
#  postable_type     :string(255)     indexed
#  user_id           :integer(4)      indexed
#  on_frontpage_week :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#  reports_count     :integer(4)      default(0), not null
#  up_votes          :integer(4)      default(0), not null
#  down_votes        :integer(4)      default(0), not null
#
# Indexes
#
#  index_posts_on_postable_id    (postable_id)
#  index_posts_on_postable_type  (postable_type)
#  index_posts_on_type           (type)
#  index_posts_on_user_id        (user_id)
#

