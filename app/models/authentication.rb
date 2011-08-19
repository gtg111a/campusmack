class Authentication < ActiveRecord::Base
  belongs_to :user

  def to_s
    self.provider.to_s
  end

end
