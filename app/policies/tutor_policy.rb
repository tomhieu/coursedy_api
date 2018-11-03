class TutorPolicy
  attr_reader :user, :tutor

  def initialize(user, tutor)
    @user = user
    @tutor = tutor
  end

  def show?
    user.admin? || tutor.user_id == user.id || tutor.status == 'verified'
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || tutor.user_id == user.id
  end

  def destroy?
    update?
  end
end