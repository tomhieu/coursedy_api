class Tutor < ApplicationRecord
  belongs_to :user
  has_many :degrees
end
