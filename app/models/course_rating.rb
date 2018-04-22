class CourseRating < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :points, presence: true, inclusion: {in: [1..5]}
  validate :can_rate

  after_create :update_course_rating

  def can_rate
    unless user && user.partitions.where(course_id: course_id, user_id: user_id).exists?
      errors.add(:user_id, I18n.t("activerecord.errors.models.course_rating.attributes.user_id"))
    end

    if course && course.start_date > Time.current
      errors.add(:course_id, I18n.t("activerecord.errors.models.course_rating.attributes.course_id"))
    end
  end

  def update_course_rating
    course = self.course
    course.update_attributes(
      rating_count: course.rating_count + 1,
      rating_points: course.rating_points + self.points
    )
  end
end
