class CourseSection < ApplicationRecord
  belongs_to :course, -> { unscope(where: [:verification_status, :is_public]) }
  has_many :lessons, dependent: :destroy

  validates :title, presence: true
end
