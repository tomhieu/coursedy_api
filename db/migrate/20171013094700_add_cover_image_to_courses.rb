class AddCoverImageToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :cover_image, :string
  end
end
