class Article < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

  has_attached_file :image, :styles => { :medium => "217x163", :large => "600x600" }

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg'],
                                    :message => 'photo must be of filetype .jpg, .png or .gif'
  validates :video_url, :youtube_url_format => true

  def image_url(params=nil)
    self.image.url(params)
  end

end
