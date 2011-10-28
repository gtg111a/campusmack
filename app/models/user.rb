require 'digest'

class User < ActiveRecord::Base

  AFFILIATION_OPTIONS = %w{Student Alumni Fan}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  #Through the 'thumbs_up' gem
  acts_as_voter

  belongs_to :college
  has_many :authentications, :dependent => :destroy

  has_many :posts, :dependent => :destroy
  has_many :smacks, :dependent => :destroy
  has_many :redemptions, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :dependent => :destroy,
           :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy,
           :foreign_key => "followed_id",
           :class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :contacts
  has_many :contact_groups
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validate :confirmation_password_must_match, :if => :password_required?

  validates :terms_of_service, :acceptance => true
  validates :first_name, :presence => true,
            :length => {:maximum => 50}
  validates :last_name, :presence => true,
            :length => {:maximum => 50}
  validates :username, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => {:case_sensitive => false}
  validates :college, :presence => true
  validates :affiliation, :presence => true
  validates :gender, :presence => true
  validates :password_confirmation, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}
  has_attached_file :avatar, :styles => {:small => "39x39", :medium => "100x100", :large => "400x400>"}

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

  alias_method :old_update_with_password, :update_with_password

  def update_with_password(params={})
    return self.old_update_with_password(params) if params.keys.include?('current_password')
    self.update_without_password(params)
  end

  def to_s
    [self.first_name, self.last_name].join(' ')
  end

  def increment_smack_send
    self.smack_count = ((self.smack_count || 0) + 1)
    self.save
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  protected

  def confirmation_password_must_match
    errors.add(:password_confirmation, "doesn't match confirmation") if password != password_confirmation
  end

end
   

 

  
