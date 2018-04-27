class CreateTutorEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :tutor_educations do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :graduated_from
      t.string :description
      t.references :tutor, foreign_key: true

      t.timestamps
    end
  end
end
