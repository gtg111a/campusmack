class Statistic < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy

end
