class Post < ActiveRecord::Base
  
  #acts_as_voteable
  
  attr_accessible :content_type, :title, :content, :comments, :vote, :photo
  
  belongs_to :college
  belongs_to :user
  
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :college
  
 # has_many :smacks, :as => :apost, :dependent => :destroy
#  has_many :redemptions, :as => :apost, :dependent => :destroy
  
  has_attached_file :photo, 
                    :styles => {:medium => "200x200"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/:style/:id/:filename"
                 
  
  #"#{RAILS_ROOT}/config/aws.yml",
  validates :type,          :presence => true
  validates :content_type,  :presence => true
  validates :title,         :presence => true
  
  
  
end
