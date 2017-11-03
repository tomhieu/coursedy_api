class WeekDaySchedule < ApplicationRecord
  belongs_to :course
  has_many :time_slots

  WEEKDAYS = {
    0 => 'sunday',
    1 => 'monday',
    2 => 'tuesday',
    3 => 'wednesday',
    4 => 'thursday',
    5 => 'friday',
    6 => 'saturday'
  }

end
