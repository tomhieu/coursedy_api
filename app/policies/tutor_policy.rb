class TutorPolicy
  attr_reader :user, :tutor

  def initialize(user, tutor)
    @user = user
    @tutor = tutor
  end

  def create?
    user.teacher? || user.admin?
  end

  def update?
    user.admin? || tutor.user_id == user.id
  end

  def destroy?
    update?
  end
end