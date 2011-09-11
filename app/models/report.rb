class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :reportable, :polymorphic => true, :counter_cache => true
  belongs_to :reason
end
