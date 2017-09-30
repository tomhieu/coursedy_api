class UpdateCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :period, :integer
    add_column :courses, :period_type, :string
    add_column :courses, :number_of_students, :integer
    add_column :courses, :tuition_fee, :integer
    add_column :courses, :currency, :string
  end
end
