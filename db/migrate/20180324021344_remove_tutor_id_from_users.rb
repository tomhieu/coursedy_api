class RemoveTutorIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :degrees, :tutor_id
  end
end
