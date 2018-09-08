class CourseSection < ApplicationRecord
  belongs_to :course, -> { unscoped.where(id: self.course_id).first }
  has_many :lessons, dependent: :destroy

  validates :title, presence: true
end
