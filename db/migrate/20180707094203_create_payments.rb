class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.bigint :from_user_id
      t.bigint :to_user_id
      t.references :course, foreign_key: true
      t.bigint :amount
      t.string :currency
      t.bigint :service_fee
      t.float :service_fee_rate
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
