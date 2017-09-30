class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, foreign_key: true
      t.boolean :is_public, default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
