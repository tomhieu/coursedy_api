class Tutor < ApplicationRecord
  belongs_to :user
  has_many :degrees

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :districts

  searchable do
    text :title, :description
    text :user do
      [user.name, user.email] if user
    end
    integer :categories, :multiple => true do
      categories.map(&:id)
    end
  end
end
