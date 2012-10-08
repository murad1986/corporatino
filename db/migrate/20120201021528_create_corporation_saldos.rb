class CreateCorporationSaldos < ActiveRecord::Migration
  def change
    create_table :corporation_saldos do |t|
      t.references :corporation
      t.decimal :startDay, :precision => 6

      t.timestamps
    end
    add_index :corporation_saldos, :corporation_id
  end
end
