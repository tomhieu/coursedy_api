class AddCityToTutors < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :teach_online, :boolean, default: false
  end
end
