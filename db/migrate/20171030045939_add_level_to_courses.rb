class AddLevelToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :course_level, foreign_key: true
  end
end
