class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :post_code
      t.string :country
      t.string :country_code

      t.timestamps
    end
  end
end
