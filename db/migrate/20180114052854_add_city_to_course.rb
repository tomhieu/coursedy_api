class AddCityToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :city, foreign_key: true
    add_reference :courses, :district, foreign_key: true
  end
end
