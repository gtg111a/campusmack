class Delivery < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, :counter_cache => true
  belongs_to :college
end


# == Schema Information
#
# Table name: deliveries
#
#  id         :integer(4)      not null, primary key
#  post_id    :integer(4)
#  user_id    :integer(4)
#  college_id :integer(4)
#  recipients :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

