class AddStatusToTutors < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :status, :integer, default: 0
  end
end
