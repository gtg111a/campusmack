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
            :length => { :maximum => 50 }
  validates :last_name, :presence => true,
            :length => { :maximum => 50 }
  validates :username, :presence => true,
            :length => { :maximum => 50 },
            :uniqueness => { :case_sensitive => false }
  validates :college, :presence => true
  validates :affiliation, :presence => true
  validates :gender, :presence => true
  validates :password_confirmation, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  has_attached_file :avatar, :styles => { :small => "39x39", :medium => "100x100", :large => "400x400>" }

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

  def update_with_password(params = {})
    return self.old_update_with_password(params) if params.keys.include?('current_password')
    self.update_without_password(params)
  end

  def to_s
    [self.first_name, self.last_name].join(' ')
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


# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  username               :string(255)     indexed
#  email                  :string(255)     default(""), not null, indexed
#  first_name             :string(255)
#  last_name              :string(255)
#  admin                  :boolean         default(FALSE)
#  college_id             :integer
#  affiliation            :string(255)
#  up_votes               :integer
#  down_votes             :integer
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)     indexed
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  censor_text            :boolean         default(TRUE)
#  smack_count            :integer         default(0)
#  gender                 :string(1)
#  birthday               :date
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#
# Indexes
#
#  index_users_on_username              (username)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

