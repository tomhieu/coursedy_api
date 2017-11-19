class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :course_section
  has_many :documents, dependent: :destroy
end
