class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :course_section
  has_many :documents, dependent: :destroy

  enum status: [:not_started, :started, :finished]

  default_scope {where(:published => true)}

  validate :belong_to_course

  after_create :update_lesson_count

  validates :title, presence: true

  private

  def belong_to_course
    errors.add(:course_id, I18n.t('common_errors.invalid_course_id')) if self.course_section.course_id != self.course_id
  end

  def update_lesson_count
    course = self.course
    course.update_attributes(lesson_count: course.lesson_count + 1)
  end
end
