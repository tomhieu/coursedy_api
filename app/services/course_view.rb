class CourseView
  def initialize(course)
    @course = course
  end

  def new_view
    token = SecureRandom.urlsafe_base64(50, false)
    Rails.cache.write(token, {course_id: @course.id, activated_time: 30.seconds.from_now})
    token
  end

  def update_course_view(token)
    cached_token = Rails.cache.read(token)
    if cached_token[:course_id] == @course.id && cached_token[:activated_time] <= Time.current
      @course.update_attributes(views: @course.views + 1)
    end
  end
end