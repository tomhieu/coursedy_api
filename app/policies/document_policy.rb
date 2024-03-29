class DocumentPolicy
  attr_reader :user, :document

  def initialize(user, document)
    @user = user
    @document = document
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    user && (user.admin? || document.lesson.course.user_id == user.id) || document.lesson.course.public?
  end

  def index?
    user && (user.admin? || document.lesson.course.user_id == user.id) || document.lesson.course.public?
  end

  def update?
    user.admin? || document.lesson.course.user_id == user.id
  end

  def destroy?
    update?
  end
end