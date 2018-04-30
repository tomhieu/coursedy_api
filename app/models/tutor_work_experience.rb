class TutorWorkExperience < ApplicationRecord
  belongs_to :tutor

  validates :title, presence: true
  validates :company, presence: true
end
