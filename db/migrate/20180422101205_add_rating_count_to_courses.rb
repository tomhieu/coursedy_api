class AddRatingCountToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :rating_count, :integer, default: 0
    add_column :courses, :rating_points, :integer, default: 0
  end
end
