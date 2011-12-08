class College < ActiveRecord::Base
  has_many :users
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy
  has_many :article_posts, :as => :postable, :dependent => :destroy
  has_many :users
  belongs_to :conference
  validates :name, :presence => true
  
  accepts_nested_attributes_for :posts

  before_save :create_permalink

  def to_param
    self.permalink
  end

  def create_permalink
    return if name.nil?
    self.permalink = name.parameterize
  end

end


# == Schema Information
#
# Table name: colleges
#
#  id                :integer         primary key
#  name              :string(255)
#  conference_id     :integer         indexed
#  permalink         :string(255)     indexed
#  created_at        :timestamp
#  updated_at        :timestamp
#  smacks_count      :integer         default(0), not null
#  redemptions_count :integer         default(0), not null
#  abbrev            :string(255)
#  users_count       :integer         default(0)
#
# Indexes
#
#  index_colleges_on_permalink      (permalink)
#  index_colleges_on_conference_id  (conference_id)
#

