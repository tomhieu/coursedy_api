class CreateDistrictsTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :districts_tutors do |t|
      t.references :district, foreign_key: true
      t.references :tutor, foreign_key: true
    end
  end
end
