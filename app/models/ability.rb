class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, Profile do |profile|
        user == profile.user
      end
      can :read, :all
      cannot :read, [Picture, PictureLink]
    end
  end
end
