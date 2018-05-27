class Tutor < ApplicationRecord
  belongs_to :user
  has_many :degrees, dependent: :destroy

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :districts
  has_many :tutor_educations

  validates :title, presence: true, on: :update

  searchable do
    text :title, :description
    text :user do
      [user.name, user.email] if user
    end

    string :roles, :multiple => true do
      user.roles.map(&:name) if user
    end

    integer :category_id, :multiple => true do
      categories.map(&:id)
    end
  end
end
