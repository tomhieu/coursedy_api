class CourseRating < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :points, presence: true, inclusion: {in: [1..10]}
  validate :can_rate

  def can_rate
    unless user && user.partitions.where(course_id: course_id, user_id: user_id).exists?
      errors.add(:user_id, I18n.t("activerecord.errors.models.course_rating.attributes.user_id"))
    end

    if course && course.start_date > Time.current
      errors.add(:course_id, I18n.t("activerecord.errors.models.course_rating.attributes.course_id"))
    end
  end
end
