class TutorWorkExperience < ApplicationRecord
  belongs_to :tutor

  validates :title, presence: true
  validates :company, presence: true
  validates :start_date, presence: true

  validate :start_and_end_date

  def start_and_end_date
    errors.add(:end_date, I18n.t('activerecord.errors.models.tutor_education.attributes.end_date.start_and_end_date')) if end_date && start_date > end_date
  end
end
