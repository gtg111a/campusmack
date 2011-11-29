class Delivery < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, :counter_cache => true
  belongs_to :college
end

# == Schema Information
#
# Table name: deliveries
#
#  id         :integer         primary key
#  post_id    :integer
#  user_id    :integer
#  college_id :integer
#  recipients :integer
#  created_at :timestamp
#  updated_at :timestamp
#

