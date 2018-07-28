class WeekDaySchedulePolicy
  attr_reader :user, :week_day_schedule

  def initialize(user, week_day_schedule)
    @user = user
    @week_day_schedule = week_day_schedule
  end

  def create?
    user.teacher? || user.admin?
  end

  def show?
    user && (user.admin? || week_day_schedule.course.user_id == user.id) || week_day_schedule.course.is_public
  end

  def index?
    user && (user.admin? || week_day_schedule.course.user_id == user.id) || week_day_schedule.course.is_public
  end

  def update?
    user.admin? || week_day_schedule.course.user_id == user.id
  end

  def destroy?
    update?
  end
end