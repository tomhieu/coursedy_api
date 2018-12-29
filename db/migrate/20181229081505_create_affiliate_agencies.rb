class CreateAffiliateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_agencies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :phone
      t.string :domain
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
