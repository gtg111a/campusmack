class Smack < Post
  acts_as_commentable

  belongs_to :postable, :polymorphic => true, :counter_cache => true
  has_many :comments, :as => :commentable, :dependent => :destroy

end
