class Category < ApplicationRecord
  belongs_to :parent, foreign_key: :category_id, class_name: 'Category', required: false
  has_many :children, foreign_key: :category_id, class_name: 'Category', dependent: :nullify
  has_many :course_levels, dependent: :destroy
  has_and_belongs_to_many :tutors

  validates_presence_of :name
end
