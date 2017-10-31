class CreateTimeSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :time_slots do |t|
      t.time :start_time
      t.time :end_time
      t.references :week_day_schedule, foreign_key: true

      t.timestamps
    end
  end
end
