class Course < ApplicationRecord
  belongs_to :tutor, class_name: 'User', foreign_key: :user_id
  validate :validate_dates
  validates :title, presence: true
  validates :period, presence: true, numericality: true, blank: true
  validates :period_type, inclusion: {in: %w(hour day week month)}, presence: true, blank: true
  validates :number_of_students, numericality: true, blank: true
  validates :tuition_fee, numericality: true, blank: true
  validates :currency, inclusion: {in: %w(vnd usd yen)}, blank: true

  private

  def validate_dates
    if start_date < Time.current || start_date > end_date
      errors.add(start_date: I18n.t("activerecord.errors.models.course.attributes.start_date"))
    end
  end
end
