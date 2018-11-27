class UpcomingClassWorker
  include Sidekiq::Worker

  def perform()
    course_ids = Course.where(status: 'started', verification_status: Course::APPROVED).pluck(:id)
    current_wday = WeekDaySchedule.days.to_a.map(&:reverse).to_h[Time.current.wday]
    WeekDaySchedule.where(course_id: course_ids).where(day: current_wday).find_each do |wd|
      period = (wd.start_time_str.to_time - Time.current)/60
      if period > 0 && period <= 15
        UpcomingClassNotificationWorker.perform_async(wd.course_id)
      end
    end
  end
end
