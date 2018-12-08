class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :phone
      t.string :domain
      t.string :owner_name

      t.timestamps
    end
  end
end
