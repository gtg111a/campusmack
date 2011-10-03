class SmackSend < ActiveRecord::Base

  def self.smac_count(user_id, post_id)
    return SmackSend.count_by_sql "select count(*) from smack_sends where user_id=#{user_id} and post_id=#{post_id}"
  end
  
end
