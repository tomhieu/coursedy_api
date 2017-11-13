class AddAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :gender, :string
  end
end
