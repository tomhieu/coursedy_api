class AddNameToDegrees < ActiveRecord::Migration[5.1]
  def change
    add_column :degrees, :name, :string
  end
end
