class CreateCourseSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subscribers do |t|
      t.references :course, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
