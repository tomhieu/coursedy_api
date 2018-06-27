class LessonPolicy
  attr_reader :user, :lesson

  def initialize(user, lesson)
    @user = user
    @lesson = lesson
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    user.admin? || lesson.course.user_id == user.id || lesson.course.is_public
  end

  def index?
    user.admin? || lesson.course.user_id == user.id || lesson.course.is_public
  end

  def update?
    user.admin? || lesson.course.user_id == user.id
  end

  def destroy?
    update?
  end
end