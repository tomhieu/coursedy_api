class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.bigint :balance, default: 0
      t.references :user, foreign_key: true
      t.string :currency

      t.timestamps
    end
  end
end
