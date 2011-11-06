class Video < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy
  validates :url, :presence => true
  validates :url, :youtube_url_format => true
end


# == Schema Information
#
# Table name: videos
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

