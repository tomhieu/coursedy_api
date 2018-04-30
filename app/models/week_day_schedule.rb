class WeekDaySchedule < ApplicationRecord
  belongs_to :course
  has_many :time_slots

  validate :start_time_must_less_than_end_time

  enum day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  DATE_ANCHOR = [
    2018, 1, 1
  ]

  def start_time=(time)
    normalized_value = DateTime.new(*(DATE_ANCHOR + time.split(':').map(&:to_i)))
    super(normalized_value)
  end

  def start_time_str
    start_time.strftime("%H:%M:%S")
  end

  def end_time=(time)
    normalized_value = DateTime.new(*(DATE_ANCHOR + time.split(':').map(&:to_i)))
    super(normalized_value)
  end

  def end_time_str
    start_time.strftime("%H:%M:%S")
  end

  def start_time_must_less_than_end_time
    errors.add(:start_time, I18n.t('activerecord.errors.models.week_day_schedule.attributes.start_time.start_time_must_less_than_end_time')) if start_time >= end_time
  end
end
