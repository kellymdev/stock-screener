class StockExchange < ApplicationRecord
  has_many :stocks, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
end
