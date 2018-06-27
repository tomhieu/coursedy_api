class DegreePolicy
  attr_reader :user, :degree

  def initialize(user, degree)
    @user = user
    @degree = degree
  end

  def create?
    user.teacher? || user.admin?
  end

  def update?
    user.admin? || degree.user_id == user.id
  end

  def destroy?
    update?
  end
end