# frozen_string_literal: true

class Stock < ApplicationRecord
  has_many :share_prices, dependent: :destroy
  has_many :dividends, dependent: :destroy
  has_many :earnings, dependent: :destroy
  belongs_to :stock_exchange

  validates :company_name, presence: true, length: { minimum: 5 }
  validates :ticker_symbol, presence: true, length: { minimum: 2 },
                            uniqueness: { scope: :stock_exchange, message: 'should be unique for each stock exchange' }
end
