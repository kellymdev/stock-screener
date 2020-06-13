class CreateShareholdersEquity < ActiveRecord::Migration[5.2]
  def change
    create_table :shareholders_equities do |t|
      t.belongs_to :stock
      t.belongs_to :year
      t.decimal :value
      t.timestamps
    end
  end
end
