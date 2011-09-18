class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable

  after_create  :increment_counter_cache
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