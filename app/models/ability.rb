class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all
      can :access, :rails_admin
      cannot :report, [Comment, Post] do |reportable|
        reportable.reports.where(:user_id => user.id).any? || reportable.user_id == user.id
      end
    else
      can :read, :all
      can :status, Conference
    end
    unless user.new_record?
      can :manage, User, :id => user.id
      can :create, Redemption
      can :create, Smack
      can :create, Comment
      can [:update, :destroy], Redemption, :user_id => user.id
      can [:update, :destroy], Smack, :user_id => user.id
      can [:update, :destroy], Comment, :user_id => user.id
      can [:vote_up, :vote_down, :send_as_smack, :send_in_email], Post
      can :create, Delivery
      can [:manage], Authentication, :user_id => user.id
      can :manage, Vote, :user_id => user.id
      can :manage, Contact, :user_id => user.id
      can :manage, ContactGroup, :user_id => user.id
      can :report, [Comment, Post] do |reportable|
        !(reportable.reports.where(:user_id => user.id).any? || reportable.user_id == user.id)
      end
      if user.role == "writer"
        can :create, [Article, ArticlePost]
      end
    end

  end
end
