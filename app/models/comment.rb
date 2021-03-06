class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include Filter
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  has_many :reports, :as => :reportable, :dependent => :destroy

end




# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  title            :string(50)
#  comment          :text
#  commentable_id   :integer(4)      indexed
#  commentable_type :string(255)     indexed
#  user_id          :integer(4)      indexed
#  created_at       :datetime
#  updated_at       :datetime
#  reports_count    :integer(4)      default(0), not null
#
# Indexes
#
#  index_comments_on_commentable_id    (commentable_id)
#  index_comments_on_commentable_type  (commentable_type)
#  index_comments_on_user_id           (user_id)
#

