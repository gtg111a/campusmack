class ArticlePost < Post
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
  acts_as_commentable

  belongs_to :postable, :polymorphic => true, :counter_cache => :smacks_count
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  #validates :title, :presence => true

  after_validation :update_summary
  
  before_save :create_permalink

  def to_param
    self.permalink
  end

  def create_permalink
    return if title.nil?
    self.permalink = title.parameterize
  end

  def update_summary
    self.summary = truncate(strip_tags(article.body), :length => Post::MAX_TEXT_LEN, :separator => ' ')
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
