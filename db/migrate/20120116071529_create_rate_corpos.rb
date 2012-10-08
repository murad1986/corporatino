class CreateRateCorpos < ActiveRecord::Migration
  def change
    create_table :rate_corpos do |t|
      t.string :name
      t.decimal :pay

      t.timestamps
    end
  end
end
