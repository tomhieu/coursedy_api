class AddIsFreeToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :is_free, :boolean, default: false
    remove_column :courses, :end_date
    remove_column :courses, :period_type
  end
end
