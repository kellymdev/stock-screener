class Stock < ApplicationRecord
  belongs_to :stock_exchange

  validates :company_name, presence: true, length: { minimum: 5 }
  validates :ticker_symbol, presence: true, length: { minimum: 2 }, uniqueness: { scope: :stock_exchange, message: 'should be unique for each stock exchange' }
end
