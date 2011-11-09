class College < ActiveRecord::Base
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy
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
#  id                :integer         not null, primary key
#  name              :string(255)
#  conference_id     :integer         indexed
#  permalink         :string(255)     indexed
#  created_at        :datetime
#  updated_at        :datetime
#  smacks_count      :integer         default(0), not null
#  redemptions_count :integer         default(0), not null
#  abbrev            :string(255)
#
# Indexes
#
#  index_colleges_on_conference_id  (conference_id)
#  index_colleges_on_permalink      (permalink)
#

