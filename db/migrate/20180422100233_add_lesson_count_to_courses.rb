class AddLessonCountToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :lesson_count, :integer, default: 0
  end
end
