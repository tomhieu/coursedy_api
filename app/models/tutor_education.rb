class TutorEducation < ApplicationRecord
  belongs_to :tutor

  default_scope {order(created_at: :desc)}

  validates :title, presence: true
  validates :graduated_from, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_and_end_date

  def start_and_end_date
    errors.add(:end_date, I18n.t('activerecord.errors.models.tutor_education.attributes.end_date.start_and_end_date')) if start_date > end_date
  end
end
