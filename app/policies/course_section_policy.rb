class CourseSectionPolicy
  attr_reader :user, :course_section

  def initialize(user, course_section)
    @user = user
    @course_section = course_section
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    user.admin? || course_section.course.user_id == user.id || course_section.course.is_public
  end

  def index?
    user.admin? || course_section.course.user_id == user.id || course_section.course.is_public
  end

  def update?
    user.admin? || course_section.course.user_id == user.id
  end

  def destroy?
    update?
  end
end