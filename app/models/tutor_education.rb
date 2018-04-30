class TutorEducation < ApplicationRecord
  belongs_to :tutor

  default_scope {order(created_at: :desc)}

  validates :title, presence: true
  validates :graduated_from, presence: true
end
