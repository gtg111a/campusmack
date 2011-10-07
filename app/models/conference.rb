class Conference < ActiveRecord::Base
  has_many :colleges
  has_many :posts, :as => :postable, :dependent => :destroy
  has_many :smacks, :as => :postable, :dependent => :destroy
  has_many :redemptions, :as => :postable, :dependent => :destroy

  def to_param
    self.name.downcase
  end

  default_scope :order => 'name'

end
