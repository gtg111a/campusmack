class ArticlePost < Post
  include ActionView::Helpers::TextHelper
  acts_as_commentable

  has_many :comments, :as => :commentable, :dependent => :destroy

  before_create :create_summary

  def create_summary
    self.summary = truncate(article.body, :length => 64, :separator => ' ')
  end
end
