class CreateAbonentTarifs < ActiveRecord::Migration
  def change
    create_table :abonent_tarifs do |t|
      t.string :name
      t.decimal :tarif, :precision => 6, :scale => 2
      t.boolean :monthly
      t.integer :user_id

      t.timestamps
    end
  end

end
