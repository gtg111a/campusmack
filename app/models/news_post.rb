class NewsPost < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

  has_attached_file :image,
                    :styles => {:small => "160x120", :medim => "217x163", :large => "600x600"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/:style/:id/:filename"


  def image_url(params=nil)
    self.image.url(params)
  end

end
