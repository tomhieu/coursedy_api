class User < ActiveRecord::Base
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :avatar, AvatarUploader

  before_save :update_avatar_name

  has_many :courses
  has_many :tutor_ratings
  has_many :participations
  has_many :course_subscribers
  has_many :enrolled_courses, source: 'course', through: :participations
  has_many :followed_courses, source: 'course', through: :course_subscribers
  has_one :tutor, dependent: :destroy
  has_many :tutor_reviews, foreign_key: :teacher_id

  validates :name, presence: true
  validates :gender, inclusion: ['F', 'M'], allow_nil: true

  ROLES = [:admin, :student, :teacher]

  after_create :create_tutor

  private

  def update_avatar_name
    self.update_columns(:avatar_name => SecureRandom.hex(30)) if avatar_changed?
  end

  def create_tutor
    self.add_role(self.role) if self.role.to_sym.in?(ROLES)
    Tutor.create(user_id: self.id)
  end
end
