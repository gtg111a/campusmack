class Ckeditor::Asset < ActiveRecord::Base
  # DEPRECATED: This deprecated method is called in
  # Ckeditor::Orm::ActiveRecord::AssetBase::ClassMethods. Re-define and
  # duplicate the call using the new ActiveRecord::Base API.
  def self.set_table_name(arg)
    self.table_name = arg
  end

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
