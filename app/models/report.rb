class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :reportable, :polymorphic => true, :counter_cache => true
  belongs_to :reason
end


# == Schema Information
#
# Table name: reports
#
#  id              :integer         not null, primary key
#  user_id         :integer         indexed
#  reportable_id   :integer         indexed
#  reportable_type :string(255)     indexed
#  reason_id       :integer
#  custom_reason   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_reports_on_user_id          (user_id)
#  index_reports_on_reportable_id    (reportable_id)
#  index_reports_on_reportable_type  (reportable_type)
#

