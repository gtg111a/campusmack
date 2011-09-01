class Redemption < Post
  acts_as_commentable
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  default_scope :order => 'created_at DESC'

end
