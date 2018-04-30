class CreateTutorReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :tutor_reviews do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.integer :teacher_id

      t.timestamps
    end
  end
end
