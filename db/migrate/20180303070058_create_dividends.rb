class CreateDividends < ActiveRecord::Migration[5.1]
  def change
    create_table :dividends do |t|
      t.belongs_to :stock
      t.belongs_to :year
      t.decimal :value
      t.timestamps
    end
  end
end
