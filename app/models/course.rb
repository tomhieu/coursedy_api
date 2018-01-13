class Course < ApplicationRecord
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, :index => :not_analyzed
    indexes :title, :analyzer => 'vi_analyzer'
    indexes :description, :analyzer => 'vi_analyzer'
  end

  mount_base64_uploader :cover_image, ImageUploader

  belongs_to :tutor, class_name: 'User', foreign_key: :user_id
  has_many :week_day_schedules, dependent: :destroy
  has_many :course_sections, dependent: :destroy
  has_many :lessons, dependent: :destroy
  belongs_to :category
  belongs_to :course_level, required: false

  validate :validate_dates
  validate :validate_creator
  validates :title, presence: true
  validates :period, numericality: true, allow_blank: true
  validates :number_of_students, numericality: true, allow_blank: true
  validates :tuition_fee, numericality: true, allow_blank: true
  validates :currency, inclusion: {in: %w(vnd usd yen)}, allow_blank: true

  scope :published, -> {where(is_public: true)}

  accepts_nested_attributes_for :week_day_schedules

  LOCATIONS = {
    1 => "Tp. Hồ Chí Minh",
    2 => "Hà Nội",
    3 => "Đà Nẵng",
    4 => "Hải Phòng",
    5 => "Cần Thơ"
  }

  private

  def validate_creator
    if !tutor || !tutor.has_role?(:teacher)
      errors.add(:user_id, I18n.t("activerecord.errors.models.course.attributes.user_id"))
    end
  end

  def validate_dates
    if start_date && start_date < Time.current
      errors.add(:start_date, I18n.t("activerecord.errors.models.course.attributes.start_date"))
    end
  end
end
