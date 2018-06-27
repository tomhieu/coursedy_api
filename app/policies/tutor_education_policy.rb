class TutorEducationPolicy
  attr_reader :user, :tutor_education

  def initialize(user, tutor_education)
    @user = user
    @tutor_education = tutor_education
  end

  def create?
    user.teacher? || user.admin?
  end

  def update?
    user.admin? || tutor_education.tutor.user_id == user.id
  end

  def destroy?
    update?
  end
end