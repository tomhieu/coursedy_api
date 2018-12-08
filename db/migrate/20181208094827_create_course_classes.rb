class CreateCourseClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :course_classes do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
