class Photo < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

  has_attached_file :image,
                    :styles => { :medium => "217x450", :large => "732x403" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/:style/:id/:filename"

  validates_presence_of :image, :on => :create

  def url(params=nil)
    self.image.url(params)
  end

end
