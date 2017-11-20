class User < ActiveRecord::Base
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :avatar, ImageUploader

  has_many :course
  has_one :tutor

  validates :name, presence: true
  validates :gender, inclusion: ['F', 'M'], allow_nil: true

  ROLES = [:admin, :student, :teacher]

  after_create :create_tutor

  private

  def create_tutor
    self.add_role(self.role) if self.role.to_sym.in?(ROLES)
    Tutor.create(user_id: self.id)
  end
end
