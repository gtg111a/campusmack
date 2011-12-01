class Authentication < ActiveRecord::Base
  belongs_to :user

  def to_s
    self.provider.to_s
  end

  def provider_enum
    ['google_apps', 'facebook', 'twitter']
  end

end


# == Schema Information
#
# Table name: authentications
#
#  id         :integer         primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#

