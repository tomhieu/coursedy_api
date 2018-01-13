class AddTimeToWeekdaySchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :week_day_schedules, :start_time, :datetime
    add_column :week_day_schedules, :end_time, :datetime
  end
end
