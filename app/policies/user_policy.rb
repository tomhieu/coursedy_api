class UserPolicy
  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def show?
    user.admin? || profile.id == user.id
  end

  def update?
    user.admin? || profile.id == user.id
  end

  def destroy?
    update?
  end
end