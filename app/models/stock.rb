class Stock < ApplicationRecord
  belongs_to :stock_exchange

  validates :company_name, presence: true, length: { minimum: 5 }
  validates :ticker_symbol, presence: true, length: { minimum: 2 }
end
