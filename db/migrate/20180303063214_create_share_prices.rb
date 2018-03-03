class CreateSharePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :share_prices do |t|
      t.belongs_to :stock
      t.belongs_to :year
      t.decimal :high_value
      t.decimal :low_value
      t.timestamps
    end
  end
end
