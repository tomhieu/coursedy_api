class Tutor < ApplicationRecord
  extend FriendlyId
  friendly_id :tutor_name, use: :slugged

  belongs_to :user, dependent: :destroy
  has_many :degrees, dependent: :destroy
  has_many :tutor_work_experiences, dependent: :destroy

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :districts
  has_many :tutor_educations, dependent: :destroy

  validates :title, presence: true, on: :update

  enum status: [ :pending, :rejected, :verified ]

  default_scope {where(status: 'verified')}

  PENDING = 'pending'
  REJECTED = 'rejected'
  VERIFIED = 'verified'

  def tutor_name
    user.name || user.email.split('@').first
  end

  searchable do
    text :title, :description
    text :user do
      [user.name, user.email] if user
    end

    integer :status

    integer :category_id, :multiple => true do
      categories.map(&:id)
    end
  end
end