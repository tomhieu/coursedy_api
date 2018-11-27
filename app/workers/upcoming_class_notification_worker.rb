class UpcomingClassNotificationWorker
  include Sidekiq::Worker

  def perform(course_id)
    course = Course.find(course_id)
    course.participations.includes(:user).each do |participation|
      UserNotifierMailer.send_upcoming_classes_notification(participation.user, course).deliver_now
    end
  end
end
