class Post < ActiveRecord::Base
  
   include PostsHelper  
  #Through the 'make_voteable' gem
  #make_voteable
  
  #Through the 'thumbs_up' gem
  acts_as_voteable
  
  #Through the 'acts_as_commentable' gem
  acts_as_commentable
  
  attr_accessible :content_type, :title, :content, :post_summary, :vote, :photo
  
  belongs_to :college
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :college
  
  
  has_attached_file :photo, 
                    :styles => {:medium => "200x200"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/:style/:id/:filename"
                 
  validates :type,          :presence => true
  validates :content_type,  :presence => true
  validates :title,         :presence => true
  
  
  
end
