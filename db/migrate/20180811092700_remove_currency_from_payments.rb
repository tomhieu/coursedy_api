class RemoveCurrencyFromPayments < ActiveRecord::Migration[5.1]
  def up
    remove_column :payments, :currency
  end

  def down
    add_column :payments, :currency, :string
  end
end
