class User < ActiveRecord::Base
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :avatar, AvatarUploader, file_name: -> (u) { u.name +  SecureRandom.hex(20)}
  
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

  after_create :create_tutor

  ROLES = [:admin, :student, :teacher]
  DEFAULT_ROLE = :student
  CLIENT_ROLE = ROLES - [:admin]

  # after_create :create_tutor

  private

  def create_tutor
    role = self.role.to_sym.in?(CLIENT_ROLE) ? self.role : DEFAULT_ROLE
    self.add_role(role)
    if self.has_role?(:teacher)
      self.add_role(:student)
      Tutor.create(user_id: self.id)
    end
  end
end
