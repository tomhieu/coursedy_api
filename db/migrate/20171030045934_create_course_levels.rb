class CreateCourseLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :course_levels do |t|
      t.integer :level
      t.string :name
      t.string :description
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
