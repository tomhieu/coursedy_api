class CreateCourseSections < ActiveRecord::Migration[5.1]
  def change
    create_table :course_sections do |t|
      t.string :title
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
