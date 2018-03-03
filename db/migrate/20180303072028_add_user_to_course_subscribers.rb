class AddUserToCourseSubscribers < ActiveRecord::Migration[5.1]
  def change
    add_reference :course_subscribers, :user, foreign_key: true
    remove_column :course_subscribers, :email
  end
end
