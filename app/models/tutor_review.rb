class TutorReview < ApplicationRecord
  belongs_to :user
  belongs_to :tutor, class_name: 'User', foreign_key: :teacher_id
end
