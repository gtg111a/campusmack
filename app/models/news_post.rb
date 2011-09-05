class NewsPost < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

end
