class TutorReviewPolicy
  attr_reader :user, :tutor_review

  def initialize(user, tutor_review)
    @user = user
    @tutor_review = tutor_review
  end

  def create?
    user.id != tutor_review.teacher_id || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    update?
  end
end