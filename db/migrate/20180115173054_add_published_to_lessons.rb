class AddPublishedToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :published, :boolean, default: false
  end
end
