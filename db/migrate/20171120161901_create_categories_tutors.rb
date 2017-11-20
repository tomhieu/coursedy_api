class CreateCategoriesTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_tutors do |t|
      t.references :category, foreign_key: true
      t.references :tutor, foreign_key: true
    end
  end
end
