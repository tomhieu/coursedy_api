class CourseSectionPolicy
  attr_reader :user, :course_section

  def initialize(user, course_section)
    @user = user
    @course_section = course_section
    @course = Course.unscoped.where(id: course_section.course_id)
  end

  def create?
    user && (user.teacher? || user.admin?)
  end

  def show?
    user && (user.admin? || course.user_id == user.id) || course.public?
  end

  def index?
    user && (user.admin? || @course.user_id == user.id) || @course.public?
  end

  def update?
    user && (user.admin? || @course.user_id == user.id)
  end

  def destroy?
    update?
  end
end