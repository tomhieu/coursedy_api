class CreateTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :title
      t.string :speciality
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
