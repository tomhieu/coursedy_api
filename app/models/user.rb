class User < ActiveRecord::Base
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :course
  has_one :tutor

  validates :first_name, presence: true

  ROLES = [:admin, :student, :teacher]

  after_create :create_tutor

  private

  def create_tutor
    self.add_role(self.role) if self.role.to_sym.in?(ROLES)
    Tutor.create(user_id: self.id, name: self.first_name)
  end
end
