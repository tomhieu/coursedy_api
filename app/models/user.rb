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
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :gender, inclusion: ['F', 'M'], allow_nil: true

  after_create :create_tutor
  after_create :create_accounts

  ROLES = [:admin, :student, :teacher].freeze
  DEFAULT_ROLE = :student
  CLIENT_ROLE = (ROLES - [:admin]).freeze

  def account(c)
    accounts.where(currency: c).first
  end

  def admin?
    has_role? :admin
  end

  def teacher?
    has_role? :teacher
  end

  def student?
    has_role? :student
  end

  private

  def create_tutor
    role = self.role.to_sym.in?(CLIENT_ROLE) ? self.role : DEFAULT_ROLE
    self.add_role(role)
    if self.has_role?(:teacher)
      self.add_role(:student)
      Tutor.create(user_id: self.id)
    end
    self.update_attributes(role: role)
  end

  def create_accounts
    Account::CURRENCIES.each do |c|
      self.accounts.create(currency: c)
    end
  end
end
