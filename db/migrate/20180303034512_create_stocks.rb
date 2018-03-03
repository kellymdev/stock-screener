class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.string :ticker_symbol
      t.belongs_to :stock_exchange
      t.timestamps
    end
  end
end
