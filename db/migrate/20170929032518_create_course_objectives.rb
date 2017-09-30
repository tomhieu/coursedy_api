class CreateCourseObjectives < ActiveRecord::Migration[5.1]
  def change
    create_table :course_objectives do |t|
      t.string :content
      t.boolean :highlight
      t.references :course

      t.timestamps
    end
  end
end
