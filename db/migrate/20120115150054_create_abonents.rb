class CreateAbonents < ActiveRecord::Migration
  def change
    create_table :abonents do |t|
      t.references :corporation
      t.string    :phone
      t.integer    :delay, :default => 0
      t.boolean    :status, :default => true
      t.integer    :abonent_tarif_id
      t.string     :name
      t.boolean    :suspend, :default => true
      t.date       :start_date
      t.timestamps

    end
    add_index :abonents, :corporation_id
  end


end
