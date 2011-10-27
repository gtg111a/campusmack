class NewsPost < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

  has_attached_file :image,
                    :styles => { :medium => "217x163", :large => "600x600" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/news/:style/:id/:filename"

  validates :url, :presence => true
  validates :url, :url_format => true

  def image_url(params=nil)
    self.image.url(params)
  end

end
