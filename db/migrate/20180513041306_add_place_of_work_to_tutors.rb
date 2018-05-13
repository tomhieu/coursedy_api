class AddPlaceOfWorkToTutors < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :place_of_work, :string
  end
end
