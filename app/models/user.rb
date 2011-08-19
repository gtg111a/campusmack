# == Schema Information
# Schema version: 20110616141827
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  #Through the 'thumbs_up' gem
  acts_as_voter

  attr_accessible :name, :first_name, :last_name, :email, :password, :password_confirmation, :affiliation, :college, :remember_me


  has_many :authentications, :dependent => :destroy

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :dependent => :destroy,
           :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy,
           :foreign_key => "followed_id",
           :class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :presence => true,
            :length => {:maximum => 50}
  validates :last_name, :presence => true,
            :length => {:maximum => 50}
  validates :name, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => {:case_sensitive => false}
  validates :college, :presence => true
  validates :affiliation, :presence => true


  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def apply_omniauth(omniauth)
    # Grab emails for user creation
    if (omniauth['provider'] == 'facebook')
      self.email = omniauth['extra']['user_hash']['email']
    elsif (omniauth['provider'] == 'google_apps')
      self.email = omniauth['user_info']['email']
    end
    self.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  alias_method :old_update_with_password, :update_with_password

  def update_with_password(params={})
    return self.old_update_with_password(params) if params.keys.include?('current_password')
    self.update_without_password(params)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
   

 

  
