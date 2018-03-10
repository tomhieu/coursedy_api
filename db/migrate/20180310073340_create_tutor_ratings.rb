class CreateTutorRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :tutor_ratings do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :teacher_id
      t.integer :points

      t.timestamps
    end
  end
end
