class Conference < ActiveRecord::Base
  has_many :colleges
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy
  has_many :article_posts, :as => :postable, :dependent => :destroy
  before_save :create_permalink

  def to_param
    self.name.downcase
  end

  default_scope :order => 'weight, name'

  def create_permalink
    return if name.nil?
    self.permalink = name.parameterize
  end

end


# == Schema Information
#
# Table name: conferences
#
#  id                :integer         primary key
#  name              :string(255)
#  created_at        :timestamp
#  updated_at        :timestamp
#  smacks_count      :integer         default(0), not null
#  redemptions_count :integer         default(0), not null
#  division          :string(255)     indexed
#  permalink         :string(255)     indexed
#  weight            :integer         default(0)
#
# Indexes
#
#  index_conferences_on_permalink  (permalink)
#  index_conferences_on_division   (division)
#

