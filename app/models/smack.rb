class Smack < Post
  
  acts_as_commentable
  
  has_many :comments, :as => :commentable, :dependent => :destroy

  
end
