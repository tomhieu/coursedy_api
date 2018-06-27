class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates_uniqueness_of :user_id, scope: :course_id
  validate :not_course_owner

  private

  def not_course_owner
    errors.add(:user_id, I18n.t("activerecord.errors.models.participation.attributes.user_id")) if course.user_id == self.user_id
  end
end
