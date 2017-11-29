class AddSlugsToDistricts < ActiveRecord::Migration[5.1]
  def change
    add_column :districts, :slug, :string
  end
end
