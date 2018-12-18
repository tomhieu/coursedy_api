class AddVnLangToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :en_lang_name, :string
  end
end
