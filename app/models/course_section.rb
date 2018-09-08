class CourseSection < ApplicationRecord
  belongs_to :course, required: false
  has_many :lessons, dependent: :destroy

  validates :title, presence: true

  validate :check_course

  private
  def check_course
    errors.add(:course_id, 'is required') if !self.course_id || !Course.unscoped.where(id: self.course_id).exists?
  end
end
