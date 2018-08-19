class Tutor < ApplicationRecord
  belongs_to :user
  has_many :degrees, dependent: :destroy

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :districts
  has_many :tutor_educations, dependent: :destroy

  validates :title, presence: true, on: :update

  enum status: [ :pending, :rejected, :verified ]

  PENDING = 'pending'
  REJECTED = 'rejected'
  VERIFIED = 'verified'

  default_scope {where(status: 'verified')}

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
