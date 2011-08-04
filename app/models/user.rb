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
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
   #after_create :send_welcome_email 
   
   #devise :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  #Through the 'thumbs_up' gem
  acts_as_voter
  
  #attr_accessor :password
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :affiliation, :college, :remember_me


  has_many :services, :dependent => :destroy  

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
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :first_name, :presence => true,
                    :length => { :maximum => 50 }
  validates :last_name, :presence => true,
                    :length => { :maximum => 50 } 
  validates :username, :presence => true,
                    :length => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }                 
  validates :email, :presence => true,
                    #:email => true, 
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
  validates :college, :presence => true
  validates :affiliation, :presence => true

  #before_save :encrypt_password
  
#  def has_password?(submitted_password)
#    encrypted_password == encrypt(submitted_password)
#  end
  
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
  
  private

    def send_welcome_email
        UserMailer.welcome_email(self).deliver
      end
  end
   

 
=begin
  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
    
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.password_salt == cookie_salt) ? user : nil
    end
  end
=end
=begin  
  private
  
    def encrypt_password
      self.password_salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{password_salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
=end    

  
