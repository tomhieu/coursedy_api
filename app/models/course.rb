require 'elasticsearch/model'

class Course < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :id, type: :integer
    indexes :category_id, type: :integer
    indexes :is_public, type: :boolean
    indexes :city_id, type: :integer
    indexes :title, analyzer: 'english'
    indexes :description, analyzer: 'english'
  end

  mount_base64_uploader :cover_image, ImageUploader

  belongs_to :tutor, class_name: 'User', foreign_key: :user_id
  has_many :week_day_schedules, dependent: :destroy
  has_many :course_sections, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :course_level, required: false
  belongs_to :city, required: false
  belongs_to :district, required: false

  validate :validate_dates, on: :create, allow_blank: true
  validate :validate_creator
  validates :title, presence: true
  validates :period, numericality: true, allow_blank: true
  validates :number_of_students, numericality: true, allow_blank: true
  validates :tuition_fee, numericality: true, allow_blank: true
  validates :currency, inclusion: {in: %w(vnd usd yen)}, allow_blank: true

  default_scope {where(:is_public => true)}
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
