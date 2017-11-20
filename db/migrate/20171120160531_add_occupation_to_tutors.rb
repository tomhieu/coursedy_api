class AddOccupationToTutors < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :hour_rate, :integer
    add_column :tutors, :highest_education, :string
    remove_column :tutors, :name, :string
    remove_column :tutors, :speciality, :string
  end
end
