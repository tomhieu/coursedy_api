class WeekDaySchedule < ApplicationRecord
  belongs_to :course
  has_many :time_slots

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
end
