class CreateDegrees < ActiveRecord::Migration[5.1]
  def change
    create_table :degrees do |t|
      t.references :user, foreign_key: true
      t.references :tutor, foreign_key: true
      t.string :item

      t.timestamps
    end
  end
end
