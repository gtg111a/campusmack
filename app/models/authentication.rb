class Authentication < ActiveRecord::Base
  belongs_to :user

  def to_s
    self.provider.to_s
  end

  def provider_enum
    ['google_apps', 'facebook', 'twitter']
  end

end
