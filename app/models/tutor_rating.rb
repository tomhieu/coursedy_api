class TutorRating < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
  belongs_to :course

  validates :teacher_id, presence: true
  validates :points, presence: true, inclusion: {in: [1..10]}
  validate :can_rate

  def can_rate
    if course && course.user_id != teacher_id
      errors.add(:teacher_id, I18n.t("activerecord.errors.models.tutor_rating.attributes.teacher_id"))
    end

    unless user && user.partitions.where(course_id: course_id, user_id: user_id).exists?
      errors.add(:user_id, I18n.t("activerecord.errors.models.tutor_rating.attributes.user_id"))
    end

    if course && course.start_date > Time.current
      errors.add(:course_id, I18n.t("activerecord.errors.models.tutor_rating.attributes.course_id"))
    end
  end
end
