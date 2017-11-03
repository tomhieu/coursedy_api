class AddLocationToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :location, :string
  end
end
