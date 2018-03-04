# frozen_string_literal: true

class StockExchangesController < ApplicationController
  before_action :find_stock_exchange, only: [:show]

  def index
    @stock_exchanges = StockExchange.all.order(:name)
  end

  def show
    @stocks = @stock_exchange.stocks.order(:ticker_symbol)
  end

  private

  def find_stock_exchange
    @stock_exchange = StockExchange.find(params[:id])
  end
end
