class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable

  after_create :increment_counter_cache
  after_destroy :decrement_counter_cache

  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

  def user_id
    voter_id if voter_type == "User"
  end

  def user_id=(id)
    voter_id = id
    voter_type = "User"
  end

  private

  def increment_counter_cache
    return unless voteable_type == "Post"
    p = Post.find(voteable_id)
    if vote
      p.up_votes += 1
    else
      p.down_votes += 1
    end
    p.save
  end

  def decrement_counter_cache
    p = Post.find(voteable_id)
    if vote
      p.up_votes -= 1
    else
      p.down_votes -= 1
    end
    p.save
  end

end


# == Schema Information
#
# Table name: votes
#
#  id            :integer         primary key
#  vote          :boolean         default(FALSE)
#  voteable_id   :integer         not null, indexed => [voteable_type], indexed => [voter_id, voter_type, voteable_type]
#  voteable_type :string(255)     not null, indexed => [voteable_id], indexed => [voter_id, voter_type, voteable_id]
#  voter_id      :integer         indexed => [voter_type], indexed => [voter_type, voteable_id, voteable_type]
#  voter_type    :string(255)     indexed => [voter_id], indexed => [voter_id, voteable_id, voteable_type]
#  created_at    :timestamp
#  updated_at    :timestamp
#
# Indexes
#
#  index_votes_on_voter_id_and_voter_type        (voter_id,voter_type)
#  index_votes_on_voteable_id_and_voteable_type  (voteable_id,voteable_type)
#  fk_one_vote_per_user_per_entity               (voter_id,voter_type,voteable_id,voteable_type)
#

