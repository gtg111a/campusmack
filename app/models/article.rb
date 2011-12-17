class Article < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

  has_attached_file :image,
                    :styles => { :medium => "217x163", :large => "732x403" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :bucket => 'Campusmack',
                    :path => "/articles/:style/:id/:filename"

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg'],
                                    :message => 'photo must be of filetype .jpg, .png or .gif'
  validates :video_url, :youtube_url_format => true

  def image_url(params=nil)
    self.image.url(params)
  end

end


# == Schema Information
#
# Table name: articles
#
#  id                 :integer(4)      not null, primary key
#  post_id            :integer(4)
#  body               :text
#  video_url          :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#
