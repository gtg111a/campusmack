require 'digest'

class User < ActiveRecord::Base

  AFFILIATION_OPTIONS = %w{Student Alumni Fan}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  #Through the 'thumbs_up' gem
  acts_as_voter

  before_destroy :decrement_counter_cache
  belongs_to :college, :counter_cache => true
  has_many :authentications, :dependent => :destroy

  has_many :posts, :dependent => :destroy
  has_many :smacks, :dependent => :destroy
  has_many :redemptions, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :contacts
  has_many :contact_groups
  has_many :deliveries
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
  validates :password_confirmation, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  has_attached_file :avatar, :styles => { :small => "39x39", :medium => "100x100", :large => "400x400>" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/avatars/:style/:id/:filename"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg'],
                                    :message => 'avatar must be of filetype .jpg, .png or .gif'

  alias_method :old_update_with_password, :update_with_password

  def update_with_password(params = {})
    return self.old_update_with_password(params) if params.keys.include?('current_password')
    self.update_without_password(params)
  end

  def to_s
    [self.first_name, self.last_name].join(' ')
  end

  def recipients_count
    self.deliveries.sum(:recipients)
  end

  def decrement_counter_cache
    College.decrement_counter 'users_count', self.college_id
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
#  id                     :integer(4)      not null, primary key
#  username               :string(255)     indexed
#  email                  :string(255)     not null, indexed
#  first_name             :string(255)
#  last_name              :string(255)
#  college_id             :integer(4)
#  affiliation            :string(255)
#  up_votes               :integer(4)
#  down_votes             :integer(4)
#  encrypted_password     :string(128)     not null
#  reset_password_token   :string(255)     indexed
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  censor_text            :boolean(1)      default(TRUE)
#  gender                 :string(1)
#  birthday               :date
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer(4)
#  avatar_updated_at      :datetime
#  posts_count            :integer(4)      default(0)
#  deliveries_count       :integer(4)      default(0)
#  role                   :string(255)     default("user")
#
# Indexes
#
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_username              (username)
#

