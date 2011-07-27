class Redemption < Post
  
  acts_as_commentable
  
  has_many :comments, :as => :commentable, :dependent => :destroy

#belongs_to :apost, :polymorphic => true

=begin  
  attr_accessible :content_type, :title, :content, :comments, :vote

  validates :content_type,  :presence => true
  validates :title,         :presence => true
  validates :content,       :presence => true
=end
  
  after_initialize :init
  
  def init
    self.vote ||= 0
  end

def apost_type=(sType)
   super(sType.to_s.classify.constantize.base_class.to_s)
 end

end
