class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    can :read, :all

    if user.is? :admin
      can :manage, :all
    elsif user.is? :user
      can :read, User, user_id: user.id
      cannot :read, Requirement
      can :manage, Availability, user_id: user.id
      can :manage, TeamsApplication, user_id: user.id
      can :read, Schedule, user_id: user.id
      can :read, Event
      can :read, Shift
      can :read, Team
    else
      can :read, Event
    end

  end
end
