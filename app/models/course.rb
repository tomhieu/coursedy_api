class Course < ApplicationRecord
  enum status: [ :not_started, :started, :finished ]
  enum verification_status: [ :pending, :rejected, :approved ]

  mount_base64_uploader :cover_image, ImageUploader, file_name: -> (c) { SecureRandom.hex(20)}

  belongs_to :user
  has_many :week_day_schedules, dependent: :destroy
  has_many :course_sections, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :course_level, required: false
  belongs_to :city, required: false
  belongs_to :district, required: false
  has_many :course_ratings, dependent: :destroy
  belongs_to :bigbluebutton_room, required: false
  has_many :participations, dependent: :destroy

  validate :validate_dates, on: :create
  validate :validate_creator
  validates :title, presence: true
  validates :period, numericality: true, allow_blank: true
  validates :number_of_students, numericality: true, allow_blank: true
  validates :tuition_fee, numericality: {greater_than_or_equal_to: 0}
  validates_presence_of :tuition_fee

  after_create :setup_bbb_room

  searchable do
    text :title, :description
    text :lessons do
      lessons.map { |lesson| lesson.description }
    end

    text :user do
      [user.name, user.email] if user
    end

    boolean :is_public
    integer :verification_status
    integer :category_id
    integer :city_id
    integer :tuition_fee
  end

  PENDING = 'pending'
  REJECTED = 'rejected'
  APPROVED = 'approved'

  NOT_STARTED = 'not_started'
  STARTED = 'started'
  FINISHED = 'finished'

  default_scope {where(is_public: true, verification_status: 'approved')}
  scope :published, -> {where(is_public: true, verification_status: 'approved')}

  accepts_nested_attributes_for :week_day_schedules

  LOCATIONS = {
    1 => "Tp. Hồ Chí Minh",
    2 => "Hà Nội",
    3 => "Đà Nẵng",
    4 => "Hải Phòng",
    5 => "Cần Thơ"
  }

  def public?
    is_public && verification_status == APPROVED
  end

  private

  def validate_creator
    unless (user.teacher? || user.admin?)
      errors.add(:user_id, I18n.t("activerecord.errors.models.course.attributes.user_id"))
    end
  end

  def validate_dates
    if start_date && start_date < Time.current
      errors.add(:start_date, I18n.t("activerecord.errors.models.course.attributes.start_date"))
    end
  end

  def setup_bbb_room
    bbb_room = BigbluebuttonRoom.create(
      owner_id: self.user_id,
      meetingid: BigbluebuttonRoom.new.unique_meetingid,
      max_participants: 6,
      record_meeting: false,
      duration: 90,
      auto_start_recording: false,
      name: self.title,
      slug: "#{self.id}-#{self.title}".gsub(' ', '-'),
      owner_type: 'User',
      private: true,
      moderator_key: SecureRandom.base64(10),
      attendee_key: SecureRandom.base64(10),
      moderator_api_password: SecureRandom.uuid
    )

    self.bigbluebutton_room = bbb_room
    self.save
    bbb_room
  end
end
