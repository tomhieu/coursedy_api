class AddStudentCountToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :student_count, :integer, default: 0
  end
end
