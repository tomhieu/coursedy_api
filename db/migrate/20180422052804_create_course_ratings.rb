class CreateCourseRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :course_ratings do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
