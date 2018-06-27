class TutorWorkExperiencePolicy
  attr_reader :user, :tutor_work_experience

  def initialize(user, tutor_work_experience)
    @user = user
    @tutor_work_experience = tutor_work_experience
  end

  def create?
    user.teacher? || user.admin?
  end

  def update?
    user.admin? || tutor_work_experience.tutor.user_id == user.id
  end

  def destroy?
    update?
  end
end