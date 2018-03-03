class CourseSubscriber < ApplicationRecord
  belongs_to :course
  validates :course_id, presence: true
  validates :user_id, presence: true
end
