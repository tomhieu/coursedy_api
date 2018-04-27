class TutorEducation < ApplicationRecord
  belongs_to :tutor

  default_scope {order(created_at: :desc)}
end
