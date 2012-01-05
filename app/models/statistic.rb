class Statistic < ActiveRecord::Base
  belongs_to :post, :dependent => :destroy
end





# == Schema Information
#
# Table name: statistics
#
#  id         :integer(4)      not null, primary key
#  post_id    :integer(4)
#  name       :string(255)
#  data       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

