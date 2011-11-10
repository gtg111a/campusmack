class ReportsController < ApplicationController
  before_filter :authenticate_admin!

  def users
    @users = User.all
  end

  def colleges
    @colleges = College.all
  end
end
