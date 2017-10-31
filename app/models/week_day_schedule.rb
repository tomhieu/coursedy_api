class WeekDaySchedule < ApplicationRecord
  belongs_to :course
  has_many :time_slots
end
