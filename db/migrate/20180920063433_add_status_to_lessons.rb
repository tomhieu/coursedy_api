class AddStatusToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :status, :integer, default: 0
  end
end
