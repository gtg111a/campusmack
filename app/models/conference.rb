class Conference < ActiveRecord::Base
  has_many :colleges
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy

  def to_param
    self.name.downcase
  end

  default_scope :order => 'weight, name'

end


# == Schema Information
#
# Table name: conferences
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  smacks_count      :integer         default(0), not null
#  redemptions_count :integer         default(0), not null
#  division          :string(255)     indexed
#  permalink         :string(255)     indexed
#  weight            :integer         default(0)
#
# Indexes
#
#  index_conferences_on_division   (division)
#  index_conferences_on_permalink  (permalink)
#

