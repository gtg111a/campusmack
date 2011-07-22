class Post < ActiveRecord::Base
  
  attr_accessible :content_type, :title, :content, :comments, :vote, :photo
  
  belongs_to :college
  
 # has_many :smacks, :as => :apost, :dependent => :destroy
#  has_many :redemptions, :as => :apost, :dependent => :destroy
  
  has_attached_file :photo, 
                    :styles => {:medium => "200x200"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/:style/:id/:filename"
                 
  
  #"#{RAILS_ROOT}/config/aws.yml",
 # validates :post_type,     :presence => true
  validates :type,          :presence => true
  validates :content_type,  :presence => true
  validates :title,         :presence => true
  #validates :content,       :presence => true
  
 # default_scope select_without_file_columns_for(:photo)
  
end
