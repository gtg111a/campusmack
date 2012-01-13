class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
end

class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :styles => { :thumb => "180x135", :content => "732x403" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :path => "/article_images/:style/:id/:filename"

  validates_attachment_size :data, :less_than => 5.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
