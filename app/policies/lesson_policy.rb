class LessonPolicy
  attr_reader :user, :lesson

  def initialize(user, lesson)
    @user = user
    @lesson = lesson
    @course = Course.unscoped.where(id: @lesson.course_id)
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    user && (user.admin? || @course.user_id == user.id) || @course.public?
  end

  def index?
    user && (user.admin? || @course.user_id == user.id) || @course.public?
  end

  def update?
    user.admin? || @course.user_id == user.id
  end

  def destroy?
    update?
  end
end