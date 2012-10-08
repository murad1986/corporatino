class CreateAbonentDebits < ActiveRecord::Migration
  def change
    create_table :abonent_debits do |t|
      t.references :abonent
      t.decimal :amount, :precision => 6, :scale => 2
      t.integer :abonent_tarif_id
      t.timestamps
    end
    add_index :abonent_debits, :abonent_id
  end

end
