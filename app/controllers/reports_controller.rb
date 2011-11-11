class ReportsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    redirect_to users_reports_url
  end

  def users
    @users = User.order('last_name, first_name').all
  end

  def colleges
    @conferences = Conference.all
  end

  def export_users_to_csv
    outfile = "users_#{Time.now.strftime("%m-%d-%Y")}.csv"

    csv_data = CSV.generate(:row_sep => "\r\n") do |csv|
      csv << [
        "Username",
        "First Name",
        "Last Name",
        "Email",
        "College",
        "Posts",
        "Posts Sent As Smack",
        "People Smacked"
      ]
      User.order('last_name, first_name').all.each do |user|
        csv << [
          user.username,
          user.first_name,
          user.last_name,
          user.email,
          user.college.name,
          user.posts_count,
          user.deliveries_count,
          user.recipients_count
        ]
      end
    end

    send_data csv_data,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end

  def export_colleges_to_csv
    outfile = "colleges_#{Time.now.strftime("%m-%d-%Y")}.csv"
    csv_data = CSV.generate(:row_sep => "\r\n") do |csv|
      csv << [
        'Conference',
        'College',
        'Users'
      ]
      College.joins(:conference).order('conferences.name').all.each do |c|
        csv << [
          c.conference.name,
          c.name,
          c.users_count
        ]
      end
    end

    send_data csv_data,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end


end
