class CreateYears < ActiveRecord::Migration[5.1]
  def change
    create_table :years do |t|
      t.integer :year_number
      t.timestamps
    end
  end
end
