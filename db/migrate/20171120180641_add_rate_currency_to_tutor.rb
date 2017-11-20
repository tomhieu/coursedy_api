class AddRateCurrencyToTutor < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :currency, :string
  end
end
