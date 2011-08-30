class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
    unless user.new_record?
      can :manage, User, :id => user.id
      can :create, Redemption
      can :create, Smack
      can [:update, :destroy], Redemption, :user_id => user.id
      can [:update, :destroy], Smack, :user_id => user.id
      can [:vote_up, :vote_down], Post
      can [:manage], Authentication, :user_id => user.id
    end
    can :create, Support

  end
end
