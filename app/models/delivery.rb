class Delivery < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, :counter_cache => true
  belongs_to :college
end
