class CreateAbonentSaldos < ActiveRecord::Migration
  def change
    create_table :abonent_saldos do |t|
      t.references :abonent
      t.decimal :start_day, :precision => 6, :scale => 2

      t.timestamps
    end
    add_index :abonent_saldos, :abonent_id
  end
end
