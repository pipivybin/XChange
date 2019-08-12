class CreateHoldings < ActiveRecord::Migration[5.2]
  def change
    create_table :holdings do |t|
      t.string :name
      t.integer :account_id
      t.integer :stock_id
      t.integer :balance
      t.integer :price

      t.timestamps
    end
  end
end
