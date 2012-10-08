class CreateCorporationDebits < ActiveRecord::Migration
  def change
    create_table :corporation_debits do |t|
      t.references :corporation
      t.decimal :amount, :precision => 6

      t.timestamps
    end
    add_index :corporation_debits, :corporation_id
  end
end
