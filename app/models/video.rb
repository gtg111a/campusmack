class Video < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

end
