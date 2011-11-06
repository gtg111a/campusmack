class Smack < Post
  acts_as_commentable

  belongs_to :postable, :polymorphic => true, :counter_cache => true
  has_many :comments, :as => :commentable, :dependent => :destroy

end


# == Schema Information
#
# Table name: posts
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  summary           :string(255)
#  type              :string(255)     indexed
#  published         :boolean
#  postable_id       :integer         indexed
#  postable_type     :string(255)     indexed
#  user_id           :integer         indexed
#  on_frontpage_week :integer
#  created_at        :datetime
#  updated_at        :datetime
#  reports_count     :integer         default(0), not null
#  up_votes          :integer         default(0), not null
#  down_votes        :integer         default(0), not null
#
# Indexes
#
#  index_posts_on_type           (type)
#  index_posts_on_user_id        (user_id)
#  index_posts_on_postable_type  (postable_type)
#  index_posts_on_postable_id    (postable_id)
#

