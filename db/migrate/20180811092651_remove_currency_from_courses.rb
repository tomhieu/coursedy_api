class RemoveCurrencyFromCourses < ActiveRecord::Migration[5.1]
  def up
    remove_column :courses, :currency
  end

  def down
    add_column :courses, :currency, :string
  end
end
