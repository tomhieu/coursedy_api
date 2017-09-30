class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :course_section
end
