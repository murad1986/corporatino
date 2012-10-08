class CreateAbonentPayments < ActiveRecord::Migration
  def change
    create_table :abonent_payments do |t|
      t.references :abonent
      t.decimal :amount, :precision => 6, :scale => 2
      t.integer :platika_id
      t.boolean :manual

      t.timestamps
    end
    add_index :abonent_payments, :abonent_id
  end



end
