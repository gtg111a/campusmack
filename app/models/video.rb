class Video < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy
  validates :url, :presence => true
  validates :url, :youtube_url_format => true
end
