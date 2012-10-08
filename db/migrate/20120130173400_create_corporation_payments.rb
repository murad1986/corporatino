class CreateCorporationPayments < ActiveRecord::Migration
  def change
    create_table :corporation_payments do |t|
      t.references :corporation
      t.decimal :amount, :precision => 6

      t.timestamps
    end
    add_index :corporation_payments, :corporation_id
  end
end
