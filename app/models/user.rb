class User < ActiveRecord::Base
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  validates :first_name, presence: true

  ROLES = [:admin, :student, :teacher]

  def add_role(role)
    super if role.in?(ROLES)
  end
end
