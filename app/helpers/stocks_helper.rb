# frozen_string_literal: true

module StocksHelper
  def full_ticker_symbol(stock)
    "#{stock.stock_exchange.name}:#{stock.ticker_symbol}"
  end
end
