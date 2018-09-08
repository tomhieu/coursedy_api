class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :content
      t.string :note_type
      t.boolean :already_read
      t.string :target_link
      t.references :user, foreign_key: true
      t.string :image_link

      t.timestamps
    end
  end
end
