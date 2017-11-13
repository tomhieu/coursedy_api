class AddDescriptionToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :description, :text
  end
end
