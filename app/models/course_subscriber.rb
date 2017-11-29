class CourseSubscriber < ApplicationRecord
  belongs_to :course
  validates :course_id, presence: true
  validates :email, presence: true
end
