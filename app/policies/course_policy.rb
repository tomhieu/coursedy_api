class CoursePolicy
  attr_reader :user, :course

  def initialize(user, course)
    @user = user
    @course = course
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    return course.is_public unless user.present?
    user.admin? || course.user_id == user.id || course.is_public
  end

  def index?
    return course.is_public unless user.present?
    user.admin? || course.user_id == user.id || course.is_public
  end

  def update?
    user.admin? || course.user_id == user.id
  end

  def destroy?
    update?
  end
end