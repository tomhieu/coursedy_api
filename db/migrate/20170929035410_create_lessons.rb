class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.references :course, foreign_key: true
      t.references :course_section, foreign_key: true
      t.integer :period

      t.timestamps
    end
  end
end
