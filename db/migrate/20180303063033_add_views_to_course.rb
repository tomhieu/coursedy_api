class AddViewsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :views, :integer, default: 0
  end
end
