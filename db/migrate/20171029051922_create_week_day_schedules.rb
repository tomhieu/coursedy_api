class CreateWeekDaySchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :week_day_schedules do |t|
      t.integer :day
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
