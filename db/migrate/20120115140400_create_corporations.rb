class CreateCorporations < ActiveRecord::Migration
  def change
    create_table :corporations do |t|
      t.string :name
      t.string :phone
      t.string :password
      t.string :rate_megafon
      t.references :rate_corpo
      t.integer :number_count
      t.decimal :balance_megafon
      t.decimal :balance_corpo
      t.integer :status
      t.integer :user_id
      t.string  :corporation
      t.integer :delay, :default => 0
      t.timestamps
    end
    # add_index :corporations, :rate_megafon_id
    add_index :corporations, :rate_corpo_id
  end


end
