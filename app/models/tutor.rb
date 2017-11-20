class Tutor < ApplicationRecord
  belongs_to :user
  has_many :degrees

  has_and_belongs_to_many :categories
end
